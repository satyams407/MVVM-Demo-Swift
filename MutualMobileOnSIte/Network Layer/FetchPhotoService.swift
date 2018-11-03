//
//  FetchPhotoService.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//
// TODO: use network protocols 
import Foundation
import UIKit

class FetchPhotoService {

    private var url = URL.init(string: "https://jsonplaceholder.typicode.com/photos")  // can put this appURLconstants file , remove hard coding

    func fetchPhoto(completion: @escaping (Data?, AppError?) -> Void) {
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data else {
                completion(nil, AppError.init(with: AppError.ErrorType.fetchError))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(nil, AppError.init(with: AppError.ErrorType.fetchError, message: "cannot fetch"))
                return
            }
            completion(data, nil)
        }).resume()
    }
}

/*
 let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
 completion(200, data)
 })
 task.resume()
 */
