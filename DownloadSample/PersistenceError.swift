//
//  PersistenceError.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}
