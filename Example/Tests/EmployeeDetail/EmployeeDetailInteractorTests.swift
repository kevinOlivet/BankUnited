//
//  EmployeeDetailInteractorTests.swift
//  BankUnited
//
//

import BasicCommons
@testable import BankUnited
import XCTest

class EmployeeDetailInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeeDetailInteractor!
    var spyPresenter: EmployeeDetailPresentationLogicSpy!
    var spyWorker: EmployeeDetailWorkerSpy!

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupEmployeeDetailInteractor()
    }
    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeeDetailInteractor() {
        sut = EmployeeDetailInteractor()
        sut.selectedItemId = 1
        sut.selectedName = "Jon Olivet"

        spyPresenter = EmployeeDetailPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = EmployeeDetailWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles
    enum PossibleResults {
        case success
        case parsingFail
        case failure
    }

    class EmployeeDetailWorkerSpy: EmployeeDetailWorker {

        var theResult: PossibleResults = .success
        var getDataCalled = false

        override func getData(
            selectedEmployeeId: String,
            successCompletion: @escaping (EmployeeDetailModel?) -> Void,
            failureCompletion: @escaping (NTError, Int?) -> Void
        ) {
            getDataCalled = true
            switch theResult {
            case .success:
                let data = EmployeeDetailModel.Datum(
                    id: 12,
                    employeeSalary: 1234,
                    employeeAge: 123,
                    employeeName: "testemployeeName"
                )
                let model = EmployeeDetailModel(status: "success", data: data)
                successCompletion(model)
            case .parsingFail:
                successCompletion(nil)
            case .failure:
                let error = NTError.noInternetConection
                failureCompletion(error, nil)
            }
        }
    }

    // MARK: Tests
    func testPrepareSetUpUI() {
        // Given
        let request = EmployeeDetail.Texts.Request()
        // When
        sut.prepareSetUpUI(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentSetupUICalled)
        XCTAssertEqual(spyPresenter.presentSetupUIResponse?.title, "Jon Olivet")
        XCTAssertEqual(spyPresenter.presentSetupUIResponse?.buttonTitle, "GO_BACK")
    }
    func testFetchDataSuccess() {
        // Given
        spyWorker.theResult = .success
        let request = EmployeeDetail.Base.Request()
        // When
        sut.fetchData(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentDataCalled)
        XCTAssertEqual(spyPresenter.presentDataResponse?.data.employeeName, "testemployeeName")
    }
    func testFetchDataParsingFail() {
        // Given
        spyWorker.theResult = .parsingFail
        let request = EmployeeDetail.Base.Request()
        // When
        sut.fetchData(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentErrorAlertCalled)
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .service,
            "Error parsing should have a service Error"
        )
    }
    func testFetchDataGeneralFail() {
        // Given
        spyWorker.theResult = .failure
        let request = EmployeeDetail.Base.Request()
        // When
        sut.fetchData(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentErrorAlertCalled)
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .internet,
            "Error in general should have a internet Error"
        )
    }

}
