//
//  PhotoCellModel.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

struct PhotoCellModel: PhotoDisplayableProtocol {    
    var imageURL: String
    var title: String

    init(viewModel: LandingViewModel) {
        self.imageURL = viewModel.url
        self.title = viewModel.title
    }
}
