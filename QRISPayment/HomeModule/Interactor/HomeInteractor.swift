//
//  HomeInteractor.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    var coreDataHelper: CoreDataHelper? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let persistentContainer = appDelegate.persistentContainer
        let coreDataHelper = CoreDataHelper(container: persistentContainer)
        return coreDataHelper
    }()
    
    func getBalance() {
        guard let helper = coreDataHelper else { return }
        
        if let balanceModel = helper.fetchBalanceModel() {
            presenter?.didRetrieveBalance(balanceModel.balance)
        }
    }
}
