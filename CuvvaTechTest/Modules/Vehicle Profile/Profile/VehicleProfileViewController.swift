//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class VehicleProfileViewController: UIViewController {
    private(set) var viewModel: VehicleProfileViewModelType
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        collectionView.register(VehicleProfileActivePolicyCell.self, forCellWithReuseIdentifier: VehicleProfileActivePolicyCell.identifier)
        collectionView.register(VehicleProfilePolicyCell.self, forCellWithReuseIdentifier: VehicleProfilePolicyCell.identifier)
        collectionView.register(TitleHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionView.identifier)
        return collectionView
    }()
    
    private lazy var headerView = VehicleHeaderView()
    
    private let collectionViewDataSource: VehicleProfileCollectionViewDataSource
    
    init(viewModel: VehicleProfileViewModelType) {
        self.viewModel = viewModel
        self.collectionViewDataSource = VehicleProfileCollectionViewDataSource(dataSource: self.viewModel.dataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = DesignStyling.Colours.white
        self.view.backgroundColor = DesignStyling.Colours.viewsBackground
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close-icon"), style: .plain, target: self, action: #selector(dismissController))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.setBackBarItemEmpty()
        
        self.setupUI()
        self.bindViewModel()
        self.viewModel.perform(action: .viewLoaded)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: DesignStyling.Fonts.headline,
        ]
        navigationController?.navigationBar.barTintColor = DesignStyling.Colours.secondaryCTA
        navigationController?.navigationBar.isTranslucent = false
        
    }

    @objc func dismissController() {
        viewModel.perform(action: .close)
    }
    
    func setupUI() {
        collectionView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    private func bindViewModel() {
        self.title = viewModel.navigationTitle
        
        collectionView.dataSource = collectionViewDataSource
        
        self.viewModel.updateContent = { [weak self] effect in
            guard let self = self else { return }
            switch effect {
                case .loading:
                    break
                case .loaded(let model):
                    self.headerView.configure(item: model)
                    self.collectionView.reloadData()
                case .error(let title, let message):
                    let okAction: () -> Void = { self.viewModel.perform(action: .close) }
                    self.showError(title: title,
                                   message: message,
                                   okAction: okAction,
                                   okActionTitle: "Dismiss")
                    break
            }
        }
        
    }
    
}


extension VehicleProfileViewController: UICollectionViewDelegateFlowLayout {
    
    private func sectionInset(for section: Int) -> UIEdgeInsets {
        if let modelType = self.viewModel.dataSource.sectionModel(at: section) {
            switch modelType {
                case .activePolicies:
                    return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
                case .previousPolicies:
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left = sectionInset(for: indexPath.section).left
        let right = sectionInset(for: indexPath.section).right
        let width = collectionView.bounds.width - (left + right)
        if let modelType = self.viewModel.dataSource.model(at: indexPath) {
            switch modelType {
                case .activePolicy:
                    return CGSize(width: width, height: 170)
                case .previousPolicy:
                    return CGSize(width: width, height: 44)
            }
        }
        return CGSize(width: width, height: 145)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if case let .previousPolicy(item) = self.viewModel.dataSource.model(at: indexPath) {
            viewModel.perform(action: .showReceipt(policyId: item.policyId))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let modelType = self.viewModel.dataSource.sectionModel(at: section) {
            switch modelType {
                case .activePolicies:
                    return 16
                case .previousPolicies:
                    return 1
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let modelType = self.viewModel.dataSource.sectionModel(at: section) {
            switch modelType {
                case .activePolicies:
                    return 16
                case .previousPolicies:
                    return 2
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let left = sectionInset(for: section).left
        let right = sectionInset(for: section).right
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
    
}
