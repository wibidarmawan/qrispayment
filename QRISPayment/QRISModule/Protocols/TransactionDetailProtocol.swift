//
//  TransactionDetailProtocol.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

protocol TransactionDetailViewProtocol: AnyObject {
    
    var presenter: TransactionDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showDetail(_ qrisModel: QRISModel)
    func transactionSuccess()
    func showError(_ message: String)
}

protocol TransactionDetailPresenterProtocol: AnyObject {
    
    var view: TransactionDetailViewController? { get set }
    var interactor: TransactionDetailInteractorInputProtocol? { get set }
    var router: TransactionDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func proceedPayment()
    func popQRISPage()
}

protocol TransactionDetailInteractorInputProtocol: AnyObject {
    
    var presenter: TransactionDetailInteractorOutputProtocol? { get set }
    var qrisModel: QRISModel? { get set }
    
    func savePayment()
    
}

protocol TransactionDetailInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didAddPayment()
    func onError(_ message: String)
}

protocol TransactionDetailRouterProtocol: AnyObject {

    static func createTransactionDetailModule(with qrisModel: QRISModel) -> UIViewController
    
    func popQRISPage()
}
