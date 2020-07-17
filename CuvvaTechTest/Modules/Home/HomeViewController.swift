//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private(set) var viewModel: HomeViewModelType
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        collectionView.register(HomeActivePolicyCell.self, forCellWithReuseIdentifier: HomeActivePolicyCell.identifier)
        collectionView.register(HomeVehicleCell.self, forCellWithReuseIdentifier: HomeVehicleCell.identifier)
        collectionView.register(TitleHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionView.identifier)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = DesignStyling.Colours.darkIndigo
        view.hidesWhenStopped = true
        return view
    }()
    
    private let collectionViewDataSource: HomeCollectionViewDataSource
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        self.collectionViewDataSource = HomeCollectionViewDataSource(dataSource: self.viewModel.dataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignStyling.Colours.viewsBackground
        
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = DesignStyling.Colours.primary
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    private func setupUI() {
        
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindViewModel() {
        self.viewModel.perform(action: .viewLoaded)
        
        collectionView.dataSource = collectionViewDataSource
        
        self.viewModel.updateContent = { [weak self] effect in
            guard let self = self else { return }
            switch effect {
                case .loading:
                    self.activityIndicator.startAnimating()
                case .loaded:
                    self.activityIndicator.stopAnimating()
                    self.collectionView.alpha = 0.0
                    self.collectionView.reloadData()
                    self.fadeInCollectionView()
                case .error(let title, let message):
                    self.activityIndicator.stopAnimating()
                    let okAction: () -> Void = { self.viewModel.perform(action: .reload) }
                    self.showError(title: title,
                                   message: message,
                                   okAction: okAction,
                                   okActionTitle: "Retry",
                                   cancelAction: { })
            }
        }
        
    }
    
    private func fadeInCollectionView() {
        UIView.animate(withDuration: 0.2 ) {
            self.collectionView.alpha = 1.0
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let left = layout?.sectionInset.left ?? 0
        let right = layout?.sectionInset.right ?? 0
        let width = collectionView.bounds.width - (left + right)
        if let modelType = self.viewModel.dataSource.model(at: indexPath) {
            switch modelType {
                case .activeItem:
                    return CGSize(width: width, height: 145)
                case .vehicle:
                    return CGSize(width: width, height: 125)
            }
        }
        return CGSize(width: width, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.perform(action: .showvehicleProfile(indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let left = layout?.sectionInset.left ?? 0
        let right = layout?.sectionInset.right ?? 0
        return CGSize(width: collectionView.bounds.width - (left + right), height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionHeader {
            if let view = view as? TitleHeaderCollectionView {
                view.titleLabel.font = DesignStyling.Fonts.headerTitle
                view.titleLabel.textColor = DesignStyling.Colours.darkIndigo
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if case let .activeItem(item: item) = viewModel.dataSource.model(at: indexPath) {
            item.perform(action: .stopVisualCountdown)
        }
    }
    
}
