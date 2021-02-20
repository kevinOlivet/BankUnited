//
//  EmployeesListBusinessLogicSpy.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited

class EmployeesListBusinessLogicSpy: EmployeesListBusinessLogic {

    var prepareSetUpUICalled = false
    var fetchEmployeesListCalled = false
    var handleDidSelectRowCalled = false

    var prepareSetUpUIRequest: EmployeesList.Texts.Request?
    var fetchEmployeesListRequest: EmployeesList.Base.Request?
    var handleDidSelectRowRequest: EmployeesList.EmployeeDetails.Request?

    func prepareSetUpUI(request: EmployeesList.Texts.Request) {
        prepareSetUpUICalled = true
        prepareSetUpUIRequest = request
    }
    func fetchEmployeesList(request: EmployeesList.Base.Request) {
        fetchEmployeesListCalled = true
        fetchEmployeesListRequest = request
    }
    func handleDidSelectRow(request: EmployeesList.EmployeeDetails.Request) {
        handleDidSelectRowCalled = true
        handleDidSelectRowRequest = request
    }

}
