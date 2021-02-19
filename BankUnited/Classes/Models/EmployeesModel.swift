//
//  EmployeeModel.swift
//  BankUnited
//
//

import Foundation

// MARK: - EmployeesModel
struct EmployeesModel: Codable {
    let status: String
    let data: [Datum]

    // MARK: - Datum
    struct Datum: Codable {
        let id, employeeName, employeeSalary, employeeAge: String
        let profileImage: String

        enum CodingKeys: String, CodingKey {
            case id
            case employeeName = "employee_name"
            case employeeSalary = "employee_salary"
            case employeeAge = "employee_age"
            case profileImage = "profile_image"
        }
    }
}
