//
//  BankUnitedLandingRoutingLogicSpy.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited
import Foundation

class BankUnitedLandingRoutingLogicSpy: NSObject, BankUnitedLandingRoutingLogic, BankUnitedLandingDataPassing {

    var dataStore: BankUnitedLandingDataStore?
    var routeToEmployeesListCalled = false

    func routeToEmployeesList() {
        routeToEmployeesListCalled = true
    }
}
