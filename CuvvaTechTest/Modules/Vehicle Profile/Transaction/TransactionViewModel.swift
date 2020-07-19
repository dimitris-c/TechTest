//
//  TransactionViewModel.swift
//  CuvvaTechTest
//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum TransactionViewAction {
    case viewLoaded
    case back
}

enum TransactionViewEffect {
    case loading
    case loaded
    case error(title: String, message: String)
}

protocol TransactionViewModelType {
    var dataSource: SectionedModelDataSource<TransactionSectionModel> { get }
    
    // Inputs
    func perform(action: TransactionViewAction)
    
    // Outputs
    var updateContent: ((TransactionViewEffect) -> Void)? { get set }
    var navigationTitle: String { get }
    
}


final class TransactionViewModel: TransactionViewModelType {
    
    let dataSource = SectionedModelDataSource<TransactionSectionModel>()
    
    let navigationTitle = "Receipt"
    
    var updateContent: ((TransactionViewEffect) -> Void)?
    
    private let policyId: String
    private let persistence: PolicyPersistence
    
    init(policyPersistence: PolicyPersistence, policyId: String) {
        self.persistence = policyPersistence
        self.policyId = policyId
    }
    
    func perform(action: TransactionViewAction) {
        switch action {
            case .viewLoaded:
                viewLoadedAction()
            case .back:
                break
        }
    }
    
    private func viewLoadedAction() {
        
        guard let transactions = self.persistence.retrievePolicies()
            .first(where: { $0.policyId == policyId })?
            .transactions else {
                updateContent?(.error(title: "Content Error", message: "Couldn't find transactions"))
                return
        }
        
        var section: [TransactionSectionModel] = []
        for transaction in transactions {
            var items: [TransactionSectionItem] = []
            if let pricing = transaction.pricing {
                let ipt = TransactionDisplayItem(title: "Insurance premium tax", amount: pricing.ipt)
                let adminFee = TransactionDisplayItem(title: "Admin Fee", amount: pricing.extraFees)
                let insurancePremium = TransactionDisplayItem(title: "Insurance premium", amount: pricing.totalPremium)
                items.append(contentsOf: [
                    .payment(item: insurancePremium),
                    .payment(item: ipt),
                    .payment(item: adminFee)
                ])
                let totalPayable = TransactionDisplayItem(title: "Total", amount: pricing.totalPayable)
                items.append(.total(item: totalPayable))
            }
            let transactionDate = "" // missing date, perhaps should be from the timestamp of the wrapper??
            section.append(.transaction(title: transactionDate, items: items))
        }
        
        dataSource.update(data: section)
        updateContent?(.loaded)
    }
}
