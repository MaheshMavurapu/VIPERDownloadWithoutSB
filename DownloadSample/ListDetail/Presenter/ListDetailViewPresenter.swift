//
//  ListDetailViewPresenter.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 23/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewPresenterProtocol: class {
    var view: ListDetailViewPrototocol? { get set }
    var interactor: ListDetailViewInteractorProtocol? { get set }
    var router: ListDetailViewRouterProtocol? { get set }
    
    var post: Hits? { get set }
    func viewDidLoad()
}

class ListDetailViewPresenter: ListDetailViewPresenterProtocol {
    
    weak var view: ListDetailViewPrototocol?
    var interactor: ListDetailViewInteractorProtocol?
    var router: ListDetailViewRouterProtocol?
    
    var post: Hits?
    
    func viewDidLoad() {
        view?.showPostDetail(forPost: post!)
    }
}
