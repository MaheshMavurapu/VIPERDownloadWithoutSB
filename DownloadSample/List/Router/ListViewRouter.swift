//
//  ListViewRouter.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewRouterProtocol: class {
    static func createListViewController() -> UIViewController
    func presentListDetailScreen(from view: ListViewProtocol, forPost post: Hits)
}

class ListViewRouter: ListViewRouterProtocol {
    
    class func createListViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let listViewController = ListViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        navigationController.viewControllers = [listViewController]
        if let view = navigationController.children.first as? ListViewController {
            
            let presenter: ListViewPresenterProtocol = ListViewPresenter()
            let interactor: ListViewInteractorProtocol = ListViewInteractor()
            let entity: ListViewEntityProtocol = ListViewEntity()
            let router: ListViewRouterProtocol = ListViewRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            interactor.entity = entity
            
            return navigationController
        }
        return UIViewController()
    }
    
    func presentListDetailScreen(from view: ListViewProtocol, forPost post: Hits) {
        let listDetailViewController = ListDetailViewRouter.createListDetailViewController(forView: view as? UIViewController, forPost: post)
        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(listDetailViewController, animated: true)
        }
    }
}

