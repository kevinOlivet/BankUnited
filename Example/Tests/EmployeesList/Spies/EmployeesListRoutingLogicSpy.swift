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

    var dataStore: EmployeesListDataStore?

    var closeToDashboardCalled = false
    var routeToEmployeeDetailCalled = false
    var routeToCreateNewEmployeeCalled = false

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
