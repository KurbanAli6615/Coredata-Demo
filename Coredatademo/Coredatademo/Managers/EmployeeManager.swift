//
//  EmployeeManager.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import Foundation

struct EmployeeManager {
    
    private let _empDataRepo = EmployeeDataRepo()
    
    func create(employee: EMP1) {
        _empDataRepo.create(employee: employee)
    }
    func getAll() -> [EMP1]? {
        return _empDataRepo.getAll()
    }
    func getById(id: UUID) -> EMP1? {
        return _empDataRepo.getById(id: id)
    }
    func update(employee: EMP1) -> Bool {
        return _empDataRepo.update(employee: employee)
    }
    func delete(employee: EMP1) -> Bool {
        return _empDataRepo.delete(employee: employee)
    }
}
