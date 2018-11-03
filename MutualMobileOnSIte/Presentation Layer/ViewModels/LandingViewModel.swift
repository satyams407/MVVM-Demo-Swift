//
//  LandingViewModel.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import Alamofire

class LandingViewModel {

    var dataSourceArray: [PhotoCellModel] = []
    let fetchPhotoService = FetchPhotoService()

    //MARK: Fetch photos network call
    func fetchPhotos(completion: @escaping ([PhotoCellModel]?, AppError?) -> Void) {
        guard let rm = NetworkReachabilityManager(), rm.isReachable else {
            completion(nil, AppError.init(with: AppError.ErrorType.networkError))
            return
        }

        fetchPhotoService.fetchPhoto(completion: { (data, error) in
            guard let data = data else {
                completion(nil , AppError.init(with: AppError.ErrorType.fetchError))
                return
            }

            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                guard let jsonObject = jsonObject else {
                    completion(nil,AppError.init(with: AppError.ErrorType.fetchError, message: "conversio"))
                    return
                }
                for json in jsonObject {
                    self.dataSourceArray.append(self.parseJson(json))
                }
            }
            completion(self.dataSourceArray, nil)
        })
    }

   fileprivate func parseJson(_ json: [String: AnyObject]) -> PhotoCellModel {
        let title = json["title"] as? String ?? ""
        let id =  json["title"] as? Int ?? 0
        let albumId =  json["albumId"] as? Int ?? 0
        let url =  json["url"] as? String ?? ""
        let thumbnailUrl =  json["thumbnailUrl"] as? String ?? ""

        return PhotoCellModel.init(imageURL: url, title: title, id: id, albumId: albumId, thumbnailUrl: thumbnailUrl)
    }
}
