//
//  TransactionDetailRouter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

class TransactionDetailRouter: TransactionDetailRouterProtocol {
    
    static func createTransactionDetailModule(with qrisModel: QRISModel) -> UIViewController {
        let viewController = TransactionDetailViewController()
        let presenter: TransactionDetailPresenterProtocol & TransactionDetailInteractorOutputProtocol = TransactionDetailPresenter()
        let interactor: TransactionDetailInteractorInputProtocol = TransactionDetailInteractor()
        let router = TransactionDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.qrisModel = qrisModel
        
        return viewController
    }
    
    func popQRISPage() {
        UIViewController.currentViewController()?.dismiss(animated: true)
    }
}
