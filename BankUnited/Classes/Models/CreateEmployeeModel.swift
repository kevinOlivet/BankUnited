//
//  CreateEmployeeModel.swift
//  BankUnited
//
//

import Foundation

// MARK: - CreateEmployeeModel
struct CreateEmployeeModel: Codable {
    let status: String
    let data: DataClass

    // MARK: - DataClass
    struct DataClass: Codable {
        let name, salary, age: String
        let id: Int
    }
}
