//
//  ManageEmployeeVC.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import UIKit

class ManageEmployeeVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet var userImage: UIImageView!
    var imagePicker: ImagePicker!
    
    let manager = EmployeeManager()
    
    
    var isFromEdit: Bool = false
    var emp: EMP1? = nil
    
    var validationError: String = ""
    var isValid: Bool {
        validationError = ""
        validate()
        return validationError == ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = 50
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        nameTextField.delegate = self
        mobileNoTextField.delegate = self
        emailTextField.delegate = self
        
        let barButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(didDeleteTapped))
        barButton.tintColor = .red
        
        let barUpdate = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didDeleteTapped))
        barUpdate.tintColor = .systemBlue
        
        if isFromEdit {
            self.navigationItem.rightBarButtonItem = barButton
            nameTextField.text = emp?.name ?? ""
            emailTextField.text = emp?.email ?? ""
            mobileNoTextField.text = emp?.mobile ?? ""
            
            saveButton.setTitle("Edit", for: .normal)
        } else {
            saveButton.setTitle("Save", for: .normal)
        }
    }
    
    
    @objc private func didDeleteTapped() {
        if manager.delete(employee: emp!) {
            Alert.shared.showAlert(type: .success, vc: self)
        } else {
            Alert.shared.showAlert(type: .failure, vc: self)
        }
    }
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
        }
    
    @IBAction func didSaveTapped(_ sender: UIButton) {
        if isValid {
            if isFromEdit {
                let emp = EMP1(name: nameTextField.text ?? "", email: mobileNoTextField.text ?? "", mobile: emailTextField.text ?? "", id: emp!.id)
                
                if manager.update(employee: emp) {
                    Alert.shared.showAlert(type: .success, vc: self)
                } else {
                    Alert.shared.showAlert(type: .failure, vc: self)
                }
            } else {
                let emp = EMP1(name: nameTextField.text ?? "", email: mobileNoTextField.text ?? "", mobile: emailTextField.text ?? "", id: UUID())
                
                manager.create(employee: emp)
                
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            Alert.shared.showAlert(type: .invalid, vc: self)
        }
    }
    
    //    MARK: - Validation
    
    private func validate() {
        if nameTextField.text?.trimmingCharacters(in: [" "]) == "" {
            validationError = "Please Enter Name"
        } else if emailTextField.text?.trimmingCharacters(in: [" "]) == "" {
            validationError = "Please Enter Email"
        } else if mobileNoTextField.text?.trimmingCharacters(in: [" "]) == "" {
            validationError = "Please Enter Mobile Number"
        }
    }
}

extension ManageEmployeeVC: UITextFieldDelegate {
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension ManageEmployeeVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.userImage.image = image ?? UIImage()
    }
}
