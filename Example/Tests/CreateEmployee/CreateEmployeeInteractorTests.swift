//
//  CreateEmployeeInteractorTests.swift
//  BankUnited
//
//

import BasicCommons
@testable import BankUnited
import XCTest

class CreateEmployeeInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: CreateEmployeeInteractor!
    var spyPresenter: CreateEmployeePresentationLogicSpy!
    var spyWorker: CreateEmployeeWorkerSpy!
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupCreateEmployeeInteractor()
    }
    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupCreateEmployeeInteractor() {
        sut = CreateEmployeeInteractor()
        sut.name = "Kevin"
        sut.salary = "1234"
        sut.age = "34"
        
        spyPresenter = CreateEmployeePresentationLogicSpy()
        sut.presenter = spyPresenter
        
        spyWorker = CreateEmployeeWorkerSpy()
        sut.worker = spyWorker
    }
    
    // MARK: Test doubles
    enum PossibleResults {
        case success
        case parsingFail
        case failure
    }
    
    class CreateEmployeeWorkerSpy: CreateEmployeeWorker {
        
        var theResult: PossibleResults = .success
        var getDataCalled = false

        override func postData(
            name: String,
            salary: String,
            age: String,
            successCompletion: @escaping (CreateEmployeeModel?) -> Void,
            failureCompletion: @escaping (NTError, Int?) -> Void
        ) {
            getDataCalled = true
            switch theResult {
            case .success:
                let data = CreateEmployeeModel.Datum(name: "testName", salary: "1234", age: "12", id: 1)
                let model = CreateEmployeeModel(status: "success", data: data)
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
        let request = CreateEmployee.Texts.Request()
        // When
        sut.prepareSetUpUI(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentSetupUICalled)
        XCTAssertEqual(spyPresenter.presentSetupUIResponse?.title, "NEW")
        XCTAssertEqual(spyPresenter.presentSetupUIResponse?.nameTitle, "NAME")
        XCTAssertEqual(spyPresenter.presentSetupUIResponse?.buttonTitle, "SUBMIT")
    }
    func testEvaluateStateSuccess() {
        // Given
        let request = CreateEmployee.EvaluateState.Request(name: "Kevin", salary: "1234", age: "123")
        // When
        sut.evaluateState(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentButtonStateCalled)
        XCTAssertEqual(spyPresenter.presentButtonStateResponse?.activateButton, true)
    }
    func testEvaluateStateFail() {
        // Given
        let request = CreateEmployee.EvaluateState.Request(name: "", salary: "", age: "")
        // When
        sut.evaluateState(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentButtonStateCalled)
        XCTAssertEqual(spyPresenter.presentButtonStateResponse?.activateButton, false)
    }
    func testFetchDataSuccess() {
        // Given
        spyWorker.theResult = .success
        let request = CreateEmployee.Base.Request()
        // When
        sut.sendData(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentDataCalled)
        XCTAssertEqual(spyPresenter.presentDataResponse?.data.name, "testName")
    }
    func testFetchDataParsingFail() {
        // Given
        spyWorker.theResult = .parsingFail
        let request = CreateEmployee.Base.Request()
        // When
        sut.sendData(request: request)
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
        let request = CreateEmployee.Base.Request()
        // When
        sut.sendData(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentErrorAlertCalled)
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .internet,
            "Error in general should have a internet Error"
        )
    }
    
}
