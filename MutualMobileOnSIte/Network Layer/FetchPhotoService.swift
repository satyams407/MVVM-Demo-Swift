//
//  FetchPhotoService.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//
//
import Foundation
import UIKit
import SwiftyJSON

enum NetworkResult {
    case success(JSON)
    case failure(NetworkError)
}

class FetchPhotoService: FetchFeedServiceProtocol {

    func fetchPhoto(withURL url: URL, completionHandler:@escaping (NetworkResult) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.failure(NetworkError.fetchError))
                }
                return
            }
            do {
                let json = try JSON(data: data)
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.success(json))
                }
            }
            catch( _) {
                DispatchQueue.main.async {
                    completionHandler(NetworkResult.failure(NetworkError.networkError))
                }
            }
            }.resume()
    }
}
