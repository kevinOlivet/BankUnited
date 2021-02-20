//
//  EmployeesListDisplayLogicSpy.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited

class EmployeesListDisplayLogicSpy: EmployeesListDisplayLogic {

    var displaySetupUICalled = false
    var displayLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var displayErrorAlertCalled = false
    var displayEmployeesArrayCalled = false
    var showEmployeeDetailCalled = false

    var displaySetupUIViewModel: EmployeesList.Texts.ViewModel?
    var displayErrorAlertViewModel: EmployeesList.Failure.ViewModel?
    var displayEmployeesArrayViewModel: EmployeesList.Employees.ViewModel?
    var showEmployeeDetailViewModel: EmployeesList.EmployeeDetails.ViewModel?

    func displaySetupUI(viewModel: EmployeesList.Texts.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
    func displayLoadingView() {
        displayLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func displayErrorAlert(viewModel: EmployeesList.Failure.ViewModel) {
        displayErrorAlertCalled = true
        displayErrorAlertViewModel = viewModel
    }
    func displayEmployeesArray(viewModel: EmployeesList.Employees.ViewModel) {
        displayEmployeesArrayCalled = true
        displayEmployeesArrayViewModel = viewModel
    }
    func showEmployeeDetail(viewModel: EmployeesList.EmployeeDetails.ViewModel) {
        showEmployeeDetailCalled = true
        showEmployeeDetailViewModel = viewModel
    }

}
