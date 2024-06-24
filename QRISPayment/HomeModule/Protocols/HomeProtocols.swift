//
//  HomeProtocols.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func showBalance(_ balance: Double)
}

protocol HomePresenterProtocol: AnyObject {
    
    var view: HomeViewController? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getBalance()
}

protocol HomeInteractorInputProtocol: AnyObject {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    
    func getBalance()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
    func didRetrieveBalance(_ balance: Double)
    
}

protocol HomeRouterProtocol: AnyObject {
    
    static func createHomeModule() -> UIViewController
    
}
