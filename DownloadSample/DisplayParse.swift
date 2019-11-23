//
//  DisplayParse.swift
//  DownloadSample
//
//  Created by ojas on 17/11/19.
//  Copyright © 2019 ojas. All rights reserved.
//

import Foundation

// Json - parse - Hits
struct DisplayParse: Decodable {
    var hits: [Hits]
    
    private enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
}

// Json - Each Hit
struct Hits: Decodable {
    var title: String
    var created_At: String
    var points: Int
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case created_At = "created_at"
        case points = "points"
    }
}
