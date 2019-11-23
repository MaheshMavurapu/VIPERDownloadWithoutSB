//
//  ListViewPresenter.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewPresenterProtocol: class {
    var view: ListViewProtocol? { get set }
    var interactor: ListViewInteractorProtocol? { get set }
    var router: ListViewRouterProtocol? { get set }
    
    func viewDidLoad()
    func didRetrieveHits(_ hits: [Hits])
    func didRetrievePosts(_ posts: [Post])
    func showPostDetail(forPost: Hits)
}

class ListViewPresenter: ListViewPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var interactor: ListViewInteractorProtocol?
    var router: ListViewRouterProtocol?
    
    func viewDidLoad() {
        DispatchQueue.main.async { [unowned self] in
            self.view?.showLoading()
        }
        interactor?.retrievePostList()
    }
    
    func didRetrieveHits(_ hits: [Hits]) {
        DispatchQueue.main.async { [unowned self] in
            self.view?.hideLoading()
        }
        view?.showPosts(hits)
    }
    
    func didRetrievePosts(_ posts: [Post]) {
        DispatchQueue.main.async { [unowned self] in
            self.view?.hideLoading()
        }
        mapHitsFromPosts(posts)
    }
    
    func mapHitsFromPosts(_ postsList: [Post]) {
        let hitsList = postsList.map() {
            return Hits(title: $0.title!, created_At: $0.createdAt!, points: Int($0.points))
        }
        view?.showPosts(hitsList)
    }
    
    func showPostDetail(forPost: Hits) {
        router?.presentListDetailScreen(from: view!, forPost: forPost)
    }
}
