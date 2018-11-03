//
//  PhotoCollectionViewCell.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView : UIImageView!
    @IBOutlet private weak var title: UILabel!
    let defaultBackgroundColor = UIColor.groupTableViewBackground

    func updateCell(with cellModel: PhotoCellModel) {
        // lazy loading
        self.imageView.downloadFromLink(link: cellModel.imageURL ?? "", contentMode: .scaleToFill)
        self.title.text = cellModel.title
       // setOpaqueBackground() //will
    }
// XIB setup
//    func setOpaqueBackground() {
//        self.alpha = 1.0
//        self.backgroundColor = defaultBackgroundColor
//        imageView.alpha = 1.0
//        imageView.backgroundColor = defaultBackgroundColor
//    }
}
