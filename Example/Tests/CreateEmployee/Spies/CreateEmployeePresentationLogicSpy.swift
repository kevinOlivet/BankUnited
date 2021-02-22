//
//  CreateEmployeePresentationLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class CreateEmployeePresentationLogicSpy: CreateEmployeePresentationLogic {
    
    // MARK: - Variables
    var presentSetupUICalled = false
    var presentLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var presentErrorAlertCalled = false
    var presentDataCalled = false
    var presentButtonStateCalled = false
    
    var presentSetupUIResponse: CreateEmployee.Texts.Response?
    var presentErrorAlertResponse: CreateEmployee.Failure.Response?
    var presentDataResponse: CreateEmployee.Base.Response?
    var presentButtonStateResponse: CreateEmployee.EvaluateState.Response?
    
    // MARK: - Methods
    func presentSetupUI(response: CreateEmployee.Texts.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
    func presentLoadingView() {
        presentLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func presentErrorAlert(response: CreateEmployee.Failure.Response) {
        presentErrorAlertCalled = true
        presentErrorAlertResponse = response
    }
    func presentData(response: CreateEmployee.Base.Response) {
        presentDataCalled = true
        presentDataResponse = response
    }
    func presentButtonState(response: CreateEmployee.EvaluateState.Response) {
        presentButtonStateCalled = true
        presentButtonStateResponse = response
    }
    
}
