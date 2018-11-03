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

    var imageURL: String? = StringConstants.emptyString

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        screenSetup()
    }

    func screenSetup() {
        if imageURL != "" {
        imageView.downloadFromLink(link: imageURL!, contentMode: .scaleToFill)
        }
    }

    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        imageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
}
