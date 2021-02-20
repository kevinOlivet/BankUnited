//
//  EmployeeDetailRoutingLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited
import Foundation

class EmployeeDetailRoutingLogicSpy: NSObject, EmployeeDetailRoutingLogic, EmployeeDetailDataPassing {

    // MARK: - Variables
    var dataStore: EmployeeDetailDataStore?
    var closeToDashboardCalled = false
    var routeToBackCalled = false

    // MARK: - Methods
    func closeToDashboard() {
        closeToDashboardCalled = true
    }
    func routeToBack() {
        routeToBackCalled = true
    }

}
