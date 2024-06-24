//
//  TransactionHistoryRouter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

class TransactionHistoryRouter: TransactionHistoryRouterProtocol {
    
    static func createTransactionHistoryModule() -> UIViewController {
        let viewController = TransactionHistoryViewController()
        let presenter: TransactionHistoryPresenterProtocol & TransactionHistoryInteractorOutputProtocol = TransactionHistoryPresenter()
        let interactor: TransactionHistoryInteractorInputProtocol = TransactionHistoryInteractor()
        let router = TransactionHistoryRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
}
