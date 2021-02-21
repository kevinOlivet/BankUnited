//
//  EmployeeDetailPresentationLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class EmployeeDetailPresentationLogicSpy: EmployeeDetailPresentationLogic {

    // MARK: - Variables
    var presentSetupUICalled = false
    var presentLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var presentErrorAlertCalled = false
    var presentDataCalled = false

    var presentSetupUIResponse: EmployeeDetail.Texts.Response?
    var presentErrorAlertResponse: EmployeeDetail.Failure.Response?
    var presentDataResponse: EmployeeDetail.Base.Response?

    // MARK: - Methods
    func presentSetupUI(response: EmployeeDetail.Texts.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
    func presentLoadingView() {
        presentLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func presentErrorAlert(response: EmployeeDetail.Failure.Response) {
        presentErrorAlertCalled = true
        presentErrorAlertResponse = response
    }
    func presentData(response: EmployeeDetail.Base.Response) {
        presentDataCalled = true
        presentDataResponse = response
    }

}
