//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class VehicleProfileViewController: UIViewController {
    private(set) var viewModel: VehicleProfileViewModelType
    
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
        collectionView.register(VehicleProfileActivePolicyCell.self, forCellWithReuseIdentifier: VehicleProfileActivePolicyCell.identifier)
        collectionView.register(VehicleProfilePolicyCell.self, forCellWithReuseIdentifier: VehicleProfilePolicyCell.identifier)
        collectionView.register(TitleHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionView.identifier)
        return collectionView
    }()
    
    
    init(viewModel: VehicleProfileViewModelType) {
        self.viewModel = viewModel
//        self.collectionViewDataSource = HomeCollectionViewDataSource(dataSource: self.viewModel.dataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DesignStyling.Colours.viewsBackground
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissController))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = DesignStyling.Colours.primary
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    @objc func dismissController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        
    }
    
}
