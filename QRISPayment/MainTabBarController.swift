//
//  MainTabBarController.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
        generateTabBar()
        setTabBarAppearance()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                        title: String,
                                         image:  UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        return navController
    }
    
    private func generateTabBar() {
        viewControllers = [
            createNavController(
                for: HomeRouter.createHomeModule(),
                title: "Home",
                image: .houseFill
            ),
            createNavController(
                for: QRISRouter.createQRISModule(),
                title: "QRIS",
                image: .qrCode
            ),
            createNavController(
                for: TransactionHistoryRouter.createTransactionHistoryModule(),
                title: "Riwayat",
                image: .clock
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14

        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        tabBar.itemWidth = width / 4
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .primary
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navController = viewController as? UINavigationController,
           navController.viewControllers.first is QRISViewController {
            let qrisViewController = UINavigationController(rootViewController: QRISRouter.createQRISModule())
            qrisViewController.modalPresentationStyle = .fullScreen
            present(qrisViewController, animated: true)
            return false
        }
        
        return true
    }
    
}
