//
//  EmpCell.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import UIKit

class EmpCell: UITableViewCell {

    static let identifier = "EmpCell"
    
    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var empEmailLabel: UILabel!
    @IBOutlet weak var empMobileLabel: UILabel!
 
    func setData(emp: EMP1)  {
        empNameLabel.text = emp.name ?? ""
        empEmailLabel.text = emp.email ?? ""
        empMobileLabel.text = emp.mobile ?? ""
    }
}
