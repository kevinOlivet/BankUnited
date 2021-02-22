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
        let id, employeeSalary, employeeAge: String
        let employeeName: String

        enum CodingKeys: String, CodingKey {
            case id
            case employeeSalary = "employee_salary"
            case employeeName = "employee_name"
            case employeeAge = "employee_age"
        }
    }


}
