//
//  TransactionHistoryInteractor.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

class TransactionHistoryInteractor: TransactionHistoryInteractorInputProtocol {
    
    var presenter: TransactionHistoryInteractorOutputProtocol?
    var coreDataHelper: CoreDataHelper? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let persistentContainer = appDelegate.persistentContainer
        let coreDataHelper = CoreDataHelper(container: persistentContainer)
        return coreDataHelper
    }()
    
    func getPaymentHistory() {
        guard let helper = coreDataHelper,
              let payments = helper.fetchAllPayments() else { return }
        
        presenter?.didRetrievePaymentHistory(payments)
    }
}
