//
//  CreateEmployeeRoutingLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited
import Foundation

class CreateEmployeeRoutingLogicSpy: NSObject, CreateEmployeeRoutingLogic, CreateEmployeeDataPassing {
    
    // MARK: - Variables
    var dataStore: CreateEmployeeDataStore?
    var closeToDashboardCalled = false
    var routeToNextSceneCalled = false
    var routeToBackCalled = false
    
    // MARK: - Methods
    func closeToDashboard() {
        closeToDashboardCalled = true
    }
    func routeToNextScene() {
        routeToNextSceneCalled = true
    }
    func routeToBack() {
        routeToBackCalled = true
    }
    
}
