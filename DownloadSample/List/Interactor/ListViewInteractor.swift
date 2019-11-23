//
//  ListViewInteractor.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewInteractorProtocol: class {
    var presenter: ListViewPresenterProtocol? { get set }
    var entity: ListViewEntityProtocol? { get set }
    
    func retrievePostList()
    func onPostsRetrieved(_ displayParse: DisplayParse)
}

class ListViewInteractor: ListViewInteractorProtocol {
    weak var presenter: ListViewPresenterProtocol?
    var entity: ListViewEntityProtocol?
    
    func retrievePostList() {
        do {
            if let postList = try entity?.retrievePostList() {
                if  postList.isEmpty {
                    self.retrievePosts() // Fetch posts.
                } else {
                   presenter?.didRetrievePosts(postList)
                }
            } else {
                self.retrievePosts() // Fetch posts.
            }
        } catch {
            presenter?.didRetrievePosts([])
        }
    }
    
    func retrievePosts() {
        guard let url = URL(string: Endpoints.Posts.fetch.url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let posts = try decoder.decode(DisplayParse.self, from:
                    dataResponse) //Decode JSON Response Data
                self.onPostsRetrieved(posts)
                print(posts)
            } catch let parsingError {
                self.presenter?.didRetrievePosts([])
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func onPostsRetrieved(_ displayParse: DisplayParse) {
        // Show to Table accoringly
        presenter?.didRetrieveHits(displayParse.hits)
        // Save to DB
        do {
            try self.entity?.savePost(displayParse)
        } catch {
            print("Error")
        }
    }
}
