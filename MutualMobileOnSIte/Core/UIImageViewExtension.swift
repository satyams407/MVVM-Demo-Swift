//
//  UIImageViewExtension.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    // try catch
    func downloadFromLink(link: String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: URL(string: link)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
