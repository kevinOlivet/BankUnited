//
//  CreateEmployeeModel.swift
//  BankUnited
//
//

import Foundation

// MARK: - CreateEmployeeModel
struct CreateEmployeeModel: Codable {
    let status: String
    let data: Datum

    // MARK: - Datum
    struct Datum: Codable {
        let name, salary, age: String
        let id: Int
    }
}
