//
//  EmployeesListInteractorTests.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

import BasicCommons
@testable import BankUnited
import XCTest

class EmployeesListInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeesListInteractor!
    var spyPresenter: EmployeesListPresentationLogicSpy!
    var spyWorker: EmployeesListWorkerSpy!

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupEmployeesListInteractor()
    }
    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeesListInteractor() {
        sut = EmployeesListInteractor()
        let item = EmployeesModel.Datum(
            id: "1",
            employeeName: "testemployeeName",
            employeeSalary: "123",
            employeeAge: "12",
            profileImage: "testprofileImage"
        )
        sut.foundEmployees = [item]
            
        spyPresenter = EmployeesListPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = EmployeesListWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles
    enum PossibleResults {
        case success
        case parsingFail
        case failure
    }

    class EmployeesListWorkerSpy: EmployeesListWorker {
        var theResult: PossibleResults = .success
        override func getEmployeesList(
            successCompletion: @escaping (EmployeesModel?) -> Void,
            failureCompletion: @escaping (NTError) -> Void
        ) {
            switch theResult {
            case .success:
                let data = EmployeesModel.Datum(
                    id: "testid",
                    employeeName: "testemployeeName",
                    employeeSalary: "testemployeeSalary",
                    employeeAge: "testemployeeAge",
                    profileImage: "testprofileImage"
                )
                let model = EmployeesModel(status: "success", data: [data])
                successCompletion(model)
            case .parsingFail:
                successCompletion(nil)
            case .failure:
                let error = NTError.noInternetConection
                failureCompletion(error)
            }
        }
    }

    // MARK: Tests
    func testPrepareSetUpUI() {
        // Given
        let request = EmployeesList.Texts.Request()
        // When
        sut.prepareSetUpUI(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentSetupUICalled)
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.title,
            "EMPLOYEES"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.buttonTitle,
            "CREATE_NEW_EMPLOYEEE"
        )
    }
    func testFetchEmployeesListSuccess() {
        // Given
        spyWorker.theResult = .success
        let request = EmployeesList.Base.Request()
        // When
        sut.fetchEmployeesList(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentEmployeesListCalled)
    }
    func testFetchEmployeesListParsingFail() {
        // Given
        spyWorker.theResult = .parsingFail
        let request = EmployeesList.Base.Request()
        // When
        sut.fetchEmployeesList(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchEmployeesList with failure parsing should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .service,
            "Error parsing should have a service Error"
        )
    }
    func testFetchEmployeesListGeneralFail() {
        // Given
        spyWorker.theResult = .failure
        let request = EmployeesList.Base.Request()
        // When
        sut.fetchEmployeesList(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchEmployeesList with failure should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .internet,
            "Error in general should have a internet Error"
        )
    }
    func testHandleDidSelectRow() {
        // Given
        sut.selectedEmployeeId = "1"
        let request = EmployeesList.EmployeeDetails.Request(indexPath: 0)
        // When
        sut.handleDidSelectRow(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentEmployeeDetailCalled)
    }

}
