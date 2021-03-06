//
//  EmployeesListPresentationLogicSpy.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited

class EmployeesListPresentationLogicSpy: EmployeesListPresentationLogic {

    // MARK: - Variables
    var presentSetupUICalled = false
    var presentLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var presentErrorAlertCalled = false
    var presentEmployeesListCalled = false
    var presentEmployeeDetailCalled = false

    var presentSetupUIResponse: EmployeesList.Texts.Response?
    var presentErrorAlertResponse: EmployeesList.Failure.Response?
    var presentEmployeesListResponse: EmployeesList.Base.Response?
    var presentEmployeeDetailResponse: EmployeesList.EmployeeDetails.Response?

    // MARK: - Methods
    func presentSetupUI(response: EmployeesList.Texts.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
    func presentLoadingView() {
        presentLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func presentErrorAlert(response: EmployeesList.Failure.Response) {
        presentErrorAlertCalled = true
        presentErrorAlertResponse = response
    }
    func presentEmployeesList(response: EmployeesList.Base.Response) {
        presentEmployeesListCalled = true
        presentEmployeesListResponse = response
    }
    func presentEmployeeDetail(response: EmployeesList.EmployeeDetails.Response) {
        presentEmployeeDetailCalled = true
        presentEmployeeDetailResponse = response
    }

}
