//
//  QRISPresenter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

class QRISPresenter: QRISPresenterProtocol {
    
    var view: QRISViewController?
    
    var interactor: QRISInteractorInputProtocol?
    
    var router: QRISRouterProtocol?
    
    func validateQRISString(_ qrisString: String) {
        interactor?.validateQRISString(qrisString)
    }
    
    func showTransactionDetail(_ qrisModel: QRISModel) {
        guard let view = self.view else { return }
        router?.presentTransactionDetailScreen(from: view, for: qrisModel)
    }
    
}

extension QRISPresenter: QRISInteractorOutputProtocol {
    
    func didRetrieveQRISModel(_ qrisModel: QRISModel) {
        view?.showTransactionDetail(qrisModel)
    }
    
    func onError(message: String) {
        view?.showError(message)
    }
    
}
