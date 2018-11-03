//
//  PhotoCellModel.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

struct PhotoCellModel {
    var imageURL: String
    var title: String
    var albumId: Int
    var id: Int
    var thumbnailUrl: String

    init(imageURL: String, title: String, id: Int, albumId: Int, thumbnailUrl: String) {
        self.imageURL = imageURL
        self.title = title
        self.albumId = albumId
        self.id = id
        self.thumbnailUrl = thumbnailUrl
    }
}
