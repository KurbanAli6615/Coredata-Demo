//
//  UserRepo.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//

import CoreData

protocol EmployeeRepo {
    func create(employee: EMP1)
    func getAll() -> [EMP1]?
    func getById(id: UUID) -> EMP1?
    func update(employee: EMP1) -> Bool
    func delete(employee: EMP1) -> Bool
}

struct EmployeeDataRepo: EmployeeRepo {
    func create(employee: EMP1) {
        let cdEmployee = Employee(context: PersistentStorage.shared.context)
        cdEmployee.name = employee.name
        cdEmployee.mobile = employee.mobile
        cdEmployee.email = employee.email
        cdEmployee.id = employee.id
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [EMP1]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObjext: Employee.self)
        var emps: [EMP1] = []
        result?.forEach({ emp in
            emps.append(emp.convertToEmployee())
        })
        
        return emps
    }
    
    func getById(id: UUID) -> EMP1? {
            let result = getEmployee(id: id)
            guard result != nil else { return nil }
        return result?.convertToEmployee()
    }
    
    func update(employee: EMP1) -> Bool {
        let cdEmp = getEmployee(id: employee.id)
        guard cdEmp != nil else { return false  }
        
        cdEmp?.email = employee.email
        cdEmp?.mobile = employee.mobile
        cdEmp?.name = employee.name
        PersistentStorage.shared.saveContext()
        
        return true

    }
    
    func delete(employee: EMP1) -> Bool {
        let cdEmp = getEmployee(id: employee.id)
        guard cdEmp != nil else { return false  }
        PersistentStorage.shared.context.delete(cdEmp!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getEmployee(id: UUID) -> Employee? {
        let fetchReq = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchReq.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchReq).first
            guard result != nil else { return nil }
            return result
        } catch let error {
            debugPrint(error)
            
            return nil
        }
    }
}
