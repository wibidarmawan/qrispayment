//
//  HomeRouter.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

class HomeRouter: HomeRouterProtocol {
    
    static func createHomeModule() -> UIViewController {
        let homeViewController = HomeViewController()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        let router = HomeRouter()
        
        homeViewController.presenter = presenter
        presenter.view = homeViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return homeViewController
    }
    
}
