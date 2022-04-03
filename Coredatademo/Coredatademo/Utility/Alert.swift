//
//  Alert.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import UIKit

class Alert {
    static let shared = Alert()
    
    func showAlert(type: AlertType, vc: UIViewController) {
        let alert = UIAlertController(title: type.rawValue, message: type.desc, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            vc.navigationController?.popViewController(animated: true)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
enum AlertType: String {
    case success = "Success"
    case failure = "Fail"
    case invalid = "Invalid"
    
    var desc: String {
        switch self {
        case .success: return "Operation Success"
        case .failure: return "Operation Fail"
        case .invalid: return "Invalid Values"
        }
    }
}
