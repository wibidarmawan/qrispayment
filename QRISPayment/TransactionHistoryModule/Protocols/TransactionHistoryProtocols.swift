//
//  TransactionHistoryProtocols.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

protocol TransactionHistoryViewProtocol: AnyObject {
    
    var presenter: TransactionHistoryPresenterProtocol? { get set }
    
    func updatePaymentHistory(_ paymentItemList: [PaymentItemModel])
}

protocol TransactionHistoryPresenterProtocol: AnyObject {
    
    var view: TransactionHistoryViewController? { get set }
    var interactor: TransactionHistoryInteractorInputProtocol? { get set }
    var router: TransactionHistoryRouterProtocol? { get set }
    
    func getPaymentHistory()
}

protocol TransactionHistoryInteractorInputProtocol: AnyObject {
    
    var presenter: TransactionHistoryInteractorOutputProtocol? { get set }
    
    func getPaymentHistory()
}

protocol TransactionHistoryInteractorOutputProtocol: AnyObject {
    
    func didRetrievePaymentHistory(_ paymentItemList: [PaymentItemModel])
    
}

protocol TransactionHistoryRouterProtocol: AnyObject {
    
    static func createTransactionHistoryModule() -> UIViewController
    
}
