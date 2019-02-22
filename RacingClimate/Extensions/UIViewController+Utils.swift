//
//  UIViewController+Utils.swift
//  RacingClimate
//
//  Created by Bernardo Carvalho on 20/02/19.
//  Copyright © 2019 Bernardo Carvalho. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show()
    }
    
    func dismissLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
    }
    
    func showAlert(_ title : String, _ message : String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}
