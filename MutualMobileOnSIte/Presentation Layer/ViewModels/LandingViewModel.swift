//
//  LandingViewModel.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LandingViewModel: Codable {
    var url: String
    var thumbnailUrl: String
    var title: String
    var id: Int
    var albumId: Int
    
    init?(json:JSON) {
        guard let data = try? json.rawData() else {
            return nil
        }
        self = try! JSONDecoder().decode(LandingViewModel.self, from: data)
    }
}
