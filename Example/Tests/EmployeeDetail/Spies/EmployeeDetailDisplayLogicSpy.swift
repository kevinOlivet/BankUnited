//
//  EmployeeDetailDisplayLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class EmployeeDetailDisplayLogicSpy: EmployeeDetailDisplayLogic {

    // MARK: - Variables
    var displaySetupUICalled = false
    var displayLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var displayErrorAlertCalled = false
    var displayDataCalled = false

    var displaySetupUIViewModel: EmployeeDetail.Texts.ViewModel?
    var displayErrorAlertViewModel: EmployeeDetail.Failure.ViewModel?
    var displayDataViewModel: EmployeeDetail.Base.ViewModel?

    // MARK: - Methods
    func displaySetupUI(viewModel: EmployeeDetail.Texts.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
    func displayLoadingView() {
        displayLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func displayErrorAlert(viewModel: EmployeeDetail.Failure.ViewModel) {
        displayErrorAlertCalled = true
        displayErrorAlertViewModel = viewModel
    }
    func displayData(viewModel: EmployeeDetail.Base.ViewModel) {
        displayDataCalled = true
        displayDataViewModel = viewModel
    }

}
