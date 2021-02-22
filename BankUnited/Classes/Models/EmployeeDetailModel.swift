//
//  EmployeeDetailModel.swift
//  BankUnited
//
//

// MARK: - EmployeeDetailModel
struct EmployeeDetailModel: Codable {
    let status: String
    let data: Datum

    // MARK: - Datum
    struct Datum: Codable {
        let id, employeeSalary, employeeAge: Int
        let employeeName: String

        enum CodingKeys: String, CodingKey {
            case id
            case employeeName = "employee_name"
            case employeeSalary = "employee_salary"
            case employeeAge = "employee_age"
        }
    }
}


