//
//  CreateEmployeeBusinessLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class CreateEmployeeBusinessLogicSpy: CreateEmployeeBusinessLogic {
    
    // MARK: - Variables
    var prepareSetUpUICalled = false
    var sendDataCalled = false
    var evaluateStateCalled = false
    
    var prepareSetUpUIRequest: CreateEmployee.Texts.Request?
    var sendDataRequest: CreateEmployee.Base.Request?
    var evaluateStateRequest: CreateEmployee.EvaluateState.Request?
    
    // MARK: - Methods
    func prepareSetUpUI(request: CreateEmployee.Texts.Request) {
        prepareSetUpUICalled = true
        prepareSetUpUIRequest = request
    }
    func sendData(request: CreateEmployee.Base.Request) {
        sendDataCalled = true
        sendDataRequest = request
    }
    func evaluateState(request: CreateEmployee.EvaluateState.Request) {
        evaluateStateCalled = true
        evaluateStateRequest = request
    }
    
}
