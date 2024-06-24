//
//  QRISProtocol.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

protocol QRISViewProtocol: AnyObject {
    
    var presenter: QRISPresenterProtocol? { get set }
    
    func showTransactionDetail(_ qrisModel: QRISModel)
    func showError(_ message: String)
}

protocol QRISPresenterProtocol: AnyObject {
    
    var view: QRISViewController? { get set }
    var interactor: QRISInteractorInputProtocol? { get set }
    var router: QRISRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func validateQRISString(_ qrisString: String)
    func showTransactionDetail(_ qrisModel: QRISModel)
}

protocol QRISInteractorInputProtocol: AnyObject {
    
    var presenter: QRISInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func validateQRISString(_ qrisString: String)
    
}

protocol QRISInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveQRISModel(_ qrisModel: QRISModel)
    func onError(message: String)
}

protocol QRISRouterProtocol: AnyObject {
    
    static func createQRISModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentTransactionDetailScreen(from view: QRISViewProtocol, for qrisModel: QRISModel)
}
