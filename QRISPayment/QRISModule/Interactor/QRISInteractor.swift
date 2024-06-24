//
//  QRISInteractor.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

class QRISInteractor: QRISInteractorInputProtocol {
    
    weak var presenter: QRISInteractorOutputProtocol?
    var qrisModel: QRISModel?
    
    func validateQRISString(_ qrisString: String) {
        guard let qrisModel = QRISHelper.parseTransactionDetails(from: qrisString) else {
            presenter?.onError(message: "Invalid QRIS format")
            return
        }
        
        presenter?.didRetrieveQRISModel(qrisModel)
    }
    
}
