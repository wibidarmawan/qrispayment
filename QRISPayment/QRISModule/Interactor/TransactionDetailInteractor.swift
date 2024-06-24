//
//  TransactionDetailInteractor.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

class TransactionDetailInteractor: TransactionDetailInteractorInputProtocol {
    
    var qrisModel: QRISModel?
    
    weak var presenter: TransactionDetailInteractorOutputProtocol?
    var coreDataHelper: CoreDataHelper? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let persistentContainer = appDelegate.persistentContainer
        let coreDataHelper = CoreDataHelper(container: persistentContainer)
        return coreDataHelper
    }()
    
    func savePayment() {
        if !validateBalance() {
            presenter?.onError("Saldo Tidak Mencukupi")
            return
        }
        
        guard let helper = coreDataHelper,
              let qrisModel = self.qrisModel,
              let balance = helper.fetchBalanceModel()?.balance else {
            presenter?.onError("Error")
            return
        }
        
        let newBalance = balance - qrisModel.transactionAmount
        _ = helper.createPayment(qrisModel: qrisModel)
        _ = helper.updateBalance(newBalance: newBalance)
        presenter?.didAddPayment()
        NotificationHandler.handleNotificationCenter(keyName: .needToRefreshBalance)
        NotificationHandler.handleNotificationCenter(keyName: .needToRefreshPaymentHistory)
    }
    
    func validateBalance() -> Bool {
        guard let helper = coreDataHelper,
              let qrisModel = self.qrisModel,
              let balance = helper.fetchBalanceModel()?.balance else { return false }
        
        return balance > qrisModel.transactionAmount
    }
}
