//
//  ListDetailViewInteractor.swift
//  DownloadSample
//
//  Created by Mahesh Mavurapu on 23/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewInteractorProtocol: class {
    var presenter: ListDetailViewPresenterProtocol? { get set }
    var entity: ListDetailViewEntityProtocol? { get set }
}

class ListDetailViewInteractor: ListDetailViewInteractorProtocol {
    
    weak var presenter: ListDetailViewPresenterProtocol?
    var entity: ListDetailViewEntityProtocol?
}
