//
//  ViewController.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import UIKit

class EmployeeListVC: UIViewController {
    

    @IBOutlet weak var empTable: UITableView!
    
    private let manager = EmployeeManager()
    
    var employees: [EMP1] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Empoyee List"
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        empTable.dataSource = self
        empTable.delegate = self
        empTable.register(UINib(nibName: EmpCell.identifier, bundle: .main), forCellReuseIdentifier: EmpCell.identifier)
        empTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cdEmps = manager.getAll()
        
        self.employees = cdEmps ?? []
        DispatchQueue.main.async {
            self.empTable.reloadData()
        }
    }
    @IBAction func didAddTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManageEmployeeVC") as! ManageEmployeeVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EmployeeListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmpCell.identifier) as! EmpCell
        cell.setData(emp: employees[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employee = employees[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManageEmployeeVC") as! ManageEmployeeVC
        vc.emp = employee
        vc.isFromEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
