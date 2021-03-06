//
//  ImageDetailViewController.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!

    var imageURL: String? = StringConstants.emptyString
    var imageLabelText: String? = StringConstants.emptyString

    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
    }

    func screenSetup() {
        if imageURL != "" {
            imageView.downloadFromLink(link: imageURL!, contentMode: .scaleToFill)
        }
        imageTitle.text = imageLabelText
    }

    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        imageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
}
