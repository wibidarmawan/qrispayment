//
//  TransactionHistoryPresenter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

class TransactionHistoryPresenter: TransactionHistoryPresenterProtocol {
    
    var view: TransactionHistoryViewController?
    
    var interactor: TransactionHistoryInteractorInputProtocol?
    
    var router: TransactionHistoryRouterProtocol?
    
    func getPaymentHistory() {
        interactor?.getPaymentHistory()
    }
}

extension TransactionHistoryPresenter: TransactionHistoryInteractorOutputProtocol {
    
    func didRetrievePaymentHistory(_ paymentItemList: [PaymentItemModel]) {
        view?.updatePaymentHistory(paymentItemList)
    }
    
}
