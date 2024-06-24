//
//  QRISRouter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

class QRISRouter: QRISRouterProtocol {
    
    static func createQRISModule() -> UIViewController {
        let qrisViewController = QRISViewController()
        let presenter: QRISPresenterProtocol & QRISInteractorOutputProtocol = QRISPresenter()
        let interactor: QRISInteractorInputProtocol = QRISInteractor()
        let router = QRISRouter()
        
        qrisViewController.presenter = presenter
        presenter.view = qrisViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return qrisViewController
    }
    
    func presentTransactionDetailScreen(from view: QRISViewProtocol, for qrisModel: QRISModel) {
        let transactionDetailVC = TransactionDetailRouter.createTransactionDetailModule(with: qrisModel)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(transactionDetailVC, animated: true)
    }
}
