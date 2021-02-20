//
//  EmployeeDetailBusinessLogicSpy.swift
//  BankUnited
//
//

@testable import BankUnited

class EmployeeDetailBusinessLogicSpy: EmployeeDetailBusinessLogic {

    // MARK: - Variables
    var prepareSetUpUICalled = false
    var fetchDataCalled = false
    var handleDidSelectRowCalled = false

    var prepareSetUpUIRequest: EmployeeDetail.Texts.Request?
    var fetchDataRequest: EmployeeDetail.Base.Request?
    var handleDidSelectRowRequest: EmployeeDetail.BaseDetails.Request?

    // MARK: - Methods
    func prepareSetUpUI(request: EmployeeDetail.Texts.Request) {
        prepareSetUpUICalled = true
        prepareSetUpUIRequest = request
    }
    func fetchData(request: EmployeeDetail.Base.Request) {
        fetchDataCalled = true
        fetchDataRequest = request
    }
    func handleDidSelectRow(request: EmployeeDetail.BaseDetails.Request) {
        handleDidSelectRowCalled = true
        handleDidSelectRowRequest = request
    }

}
