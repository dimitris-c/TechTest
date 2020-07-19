//
//  TranscationViewController.swift
//  CuvvaTechTest
//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    private(set) var viewModel: TransactionViewModelType
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TransactionAmountTableViewCell.self, forCellReuseIdentifier: TransactionAmountTableViewCell.identifier)
        tableView.register(TransactionTotalAmountTableViewCell.self, forCellReuseIdentifier: TransactionTotalAmountTableViewCell.identifier)
        return tableView
    }()
    
    private let tableViewDataSource: TransactionTableDataSource
    
    init(viewModel: TransactionViewModelType) {
        self.viewModel = viewModel
        self.tableViewDataSource = TransactionTableDataSource(dataSource: viewModel.dataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DesignStyling.Colours.viewsBackground
        self.title = viewModel.navigationTitle
    
        self.setupUI()
        self.bindViewModel()
        viewModel.perform(action: .viewLoaded)
    }
    
    private func setupUI() {
        tableView.backgroundColor = view.backgroundColor
        tableView.tableFooterView = UIView()
        tableView.dataSource = tableViewDataSource
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        
        viewModel.updateContent = { [weak self] effect in
            guard let self = self else { return }
            switch effect {
                case .loading:
                break
                case .loaded:
                    self.tableView.reloadData()
                case .error(let title, let message):
                    let okAction: () -> Void = { self.viewModel.perform(action: .back) }
                    self.showError(title: title,
                                   message: message,
                                   okAction: okAction,
                                   okActionTitle: "Dismiss")
                    break
            }
        }
        
    }
}
