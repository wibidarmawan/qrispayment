//
//  HomePresenter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewController?
    
    var interactor: HomeInteractorInputProtocol?
    
    var router: HomeRouterProtocol?
    
    func getBalance() {
        interactor?.getBalance()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func didRetrieveBalance(_ balance: Double) {
        view?.showBalance(balance)
    }
    
}
