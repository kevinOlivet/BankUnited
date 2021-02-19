//
//  APIBankUnited.swift
//  BankUnited
//
//

import Alamofire
import BasicCommons

protocol APIBankUnitedProtocol {

    func getEmployees(success: @escaping (_ result: EmployeesModel, Int) -> Void,
                      failure: @escaping (_ error: NTError, Int) -> Void)

}

class APIBankUnited: AuthenticatedAPI, APIBankUnitedProtocol {

    // Get Employee list for tableView
    func getEmployees(success: @escaping (_ result: EmployeesModel, Int) -> Void,
                      failure: @escaping (_ error: NTError, Int) -> Void) {

        let url = Configuration.Api.employeesList

        self.requestGeneric(
            type: EmployeesModel.self,
            url: url,
            method: HTTPMethod.get,
            parameters: nil,
            encoding: JSONEncoding.default,
            validStatusCodes: [Int](200..<300),
            onSuccess: { employeeModelResult, _, statusCode in
                success(employeeModelResult!, statusCode!)
            }, onFailure: { error, statusCode in
                failure(error, statusCode)
            }
        )
    }

    // Get Employee detail
    func getEmployeeDetails(selectedEmployeeId: String,
                            success: @escaping (_ result: EmployeeDetailModel, Int) -> Void,
                            failure: @escaping (_ error: NTError, Int) -> Void) {

        let url = Configuration.Api.employeeDetail + "\(selectedEmployeeId)"

        self.requestGeneric(
            type: EmployeeDetailModel.self,
            url: url,
            method: HTTPMethod.get,
            parameters: nil,
            encoding: JSONEncoding.default,
            validStatusCodes: [Int](200..<300),
            onSuccess: { employeeDetailModelResult, _, statusCode in
                success(employeeDetailModelResult!, statusCode!)
            }, onFailure: { error, statusCode in
                failure(error, statusCode)
            }
        )
    }

    // Post the new employee
    func postNewEmployee(name: String,
                         salary: String,
                         age: String,
                         success: @escaping (_ result: CreateEmployeeModel, Int) -> Void,
                         failure: @escaping (_ error: NTError, Int) -> Void) {

        let url = Configuration.Api.createEmployee

        self.requestGeneric(
            type: CreateEmployeeModel.self,
            url: url,
            method: HTTPMethod.post,
            parameters: nil,
            encoding: JSONEncoding.default,
            validStatusCodes: [Int](200..<300),
            onSuccess: { createEmployeeModelResult, _, statusCode in
                success(createEmployeeModelResult!, statusCode!)
            }, onFailure: { error, statusCode in
                failure(error, statusCode)
            }
        )
    }
}
