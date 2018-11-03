//
//  AppUtility.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

//protocol AlertPresentable {
//    func showAlert(title: String?, message: String, onController controller: UIViewController)
//}
//extension AlertPresentable where Self : UIViewController {
//    func showAlert(title: String,
//                   message: String,
//                   onController controller: UIViewController) {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//            let dismissAction = UIAlertAction(title: title, style: UIAlertAction.Style.cancel, handler: nil)
//            alert.addAction(dismissAction)
//            controller.present(alert, animated: true, completion: nil)
//        }
//    }
//}
class AppUtility {

    static func showAlert(title: String? = StringConstants.emptyString, message: String, onController controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(dismissAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
