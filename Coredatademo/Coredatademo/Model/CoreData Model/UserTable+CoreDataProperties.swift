//
//  UserTable+CoreDataProperties.swift
//  Coredatademo
//
//  Created by mac on 02/04/22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var id: UUID?

    func convertToEmployee() -> EMP1
    {
        return EMP1(name: self.name!, email: self.email!, mobile: self.mobile!, id: self.id!)
    }

}
extension Employee : Identifiable {

}
