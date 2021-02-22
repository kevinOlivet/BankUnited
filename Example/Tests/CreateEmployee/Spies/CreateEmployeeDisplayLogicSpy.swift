//
//  CreateEmployeeDisplayLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class CreateEmployeeDisplayLogicSpy: CreateEmployeeDisplayLogic {
    
    // MARK: - Variables
    var displaySetupUICalled = false
    var displayLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var displayErrorAlertCalled = false
    var displayDataCalled = false
    var displayButtonStateCalled = false
    
    var displaySetupUIViewModel: CreateEmployee.Texts.ViewModel?
    var displayErrorAlertViewModel: CreateEmployee.Failure.ViewModel?
    var displayDataViewModel: CreateEmployee.Base.ViewModel?
    var  displayButtonStateViewModel: CreateEmployee.EvaluateState.ViewModel?
    
    // MARK: - Methods
    func displaySetupUI(viewModel: CreateEmployee.Texts.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
    func displayLoadingView() {
        displayLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func displayErrorAlert(viewModel: CreateEmployee.Failure.ViewModel) {
        displayErrorAlertCalled = true
        displayErrorAlertViewModel = viewModel
    }
    func displayData(viewModel: CreateEmployee.Base.ViewModel) {
        displayDataCalled = true
        displayDataViewModel = viewModel
    }
    func displayButtonState(viewModel: CreateEmployee.EvaluateState.ViewModel) {
        displayButtonStateCalled = true
        displayButtonStateViewModel = viewModel
    }
    
}
