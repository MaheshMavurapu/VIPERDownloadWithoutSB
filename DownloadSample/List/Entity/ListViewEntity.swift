//
//  ListViewEntity.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ListViewEntityProtocol: class {
    func retrievePostList() throws -> [Post]
    func savePost(_ post: DisplayParse) throws
}

class ListViewEntity: ListViewEntityProtocol {
    
    func retrievePostList() throws -> [Post]  {
        guard let managedOC = CoreDataManager.sharedManager.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<Post> = NSFetchRequest(entityName: String(describing: Post.self))
        return try managedOC.fetch(request)
    }
    
    func savePost(_ post: DisplayParse) throws {
        guard let managedOC = CoreDataManager.sharedManager.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newPost = NSEntityDescription.entity(forEntityName: "Post",
                                                           in: managedOC) {
            do {
                try post.hits.forEach { (hit) in
                    let post = Post(entity: newPost, insertInto: managedOC)
                    post.title = hit.title
                    post.createdAt = hit.created_At
                    post.points = Int16(hit.points)
                    try managedOC.save()
                }
            } catch {
                print(error)
            }
        }
        throw PersistenceError.couldNotSaveObject
    }
}
