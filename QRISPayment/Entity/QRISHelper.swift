//
//  QRISHelper.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

final class QRISHelper {
    
    static func parseTransactionDetails(from qrisString: String) -> QRISModel? {
        let components = qrisString.components(separatedBy: ".")
        guard components.count == 4,
             let transactionAmount = Double(components[3]) else {
            return nil
        }
        
        let bankName = components[0]
        let transactionID = components[1]
        let merchantName = components[2]
        
        return QRISModel(
            bankName: bankName,
            transactionID: transactionID,
            merchantName: merchantName,
            transactionAmount: transactionAmount
        )
    }
    
}
