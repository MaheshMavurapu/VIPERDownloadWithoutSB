//
//  ListDetailViewRouter.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 23/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewRouterProtocol: class {
    static func createListDetailViewController(forView: UIViewController?, forPost post: Hits) -> UIViewController
}

class ListDetailViewRouter: ListDetailViewRouterProtocol {
    
    class func createListDetailViewController(forView: UIViewController?, forPost post: Hits) -> UIViewController {
        
        let view = ListDetailViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        let interactor: ListDetailViewInteractorProtocol = ListDetailViewInteractor()
        let presenter: ListDetailViewPresenterProtocol = ListDetailViewPresenter()
        let entity: ListDetailViewEntityProtocol = ListDetailViewEntity()
        let router: ListDetailViewRouterProtocol = ListDetailViewRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.post = post // Data
        interactor.presenter = presenter
        interactor.entity = entity

        return view
    }
}
