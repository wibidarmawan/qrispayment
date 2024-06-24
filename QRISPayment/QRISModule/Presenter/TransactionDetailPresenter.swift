//
//  TransactionDetailPresenter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

class TransactionDetailPresenter: TransactionDetailPresenterProtocol {

    var view: TransactionDetailViewController?
    
    var interactor: TransactionDetailInteractorInputProtocol?
    
    var router: TransactionDetailRouterProtocol?
    
    func viewDidLoad() {
        if let qrisModel = interactor?.qrisModel {
            view?.showDetail(qrisModel)
        }
    }
    
    func proceedPayment() {
        interactor?.savePayment()
    }
    
    func popQRISPage() {
        router?.popQRISPage()
    }
}

extension TransactionDetailPresenter: TransactionDetailInteractorOutputProtocol {
    
    func didAddPayment() {
        view?.transactionSuccess()
    }
    
    func onError(_ message: String) {
        view?.showError(message)
    }
}
