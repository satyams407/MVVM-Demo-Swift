//
//  FetchFeedServiceProtocol.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 03/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchFeedServiceProtocol {
    func fetchPhoto(withURL url: URL, completionHandler:@escaping (NetworkResult) -> Void)
}
