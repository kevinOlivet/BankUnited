//
//  EmployeesListRoutingLogicSpy.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited
import Foundation

class EmployeesListRoutingLogicSpy: NSObject, EmployeesListRoutingLogic, EmployeesListDataPassing {

    // MARK: - Variables
    var dataStore: EmployeesListDataStore?

    var closeToDashboardCalled = false
    var routeToEmployeeDetailCalled = false
    var routeToCreateNewEmployeeCalled = false

    // MARK: - Methods
    func closeToDashboard() {
        closeToDashboardCalled = true
    }
    func routeToEmployeeDetail() {
        routeToEmployeeDetailCalled = true
    }
    func routeToCreateNewEmployee() {
        routeToCreateNewEmployeeCalled = true
    }

}
