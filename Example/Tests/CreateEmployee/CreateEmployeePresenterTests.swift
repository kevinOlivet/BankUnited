//
//  CreateEmployeePresenterTests.swift
//  BankUnited
//
//

@testable import BankUnited
import XCTest

class CreateEmployeePresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: CreateEmployeePresenter!
    var spyViewController: CreateEmployeeDisplayLogicSpy!
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupCreateEmployeePresenter()
    }
    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupCreateEmployeePresenter() {
        sut = CreateEmployeePresenter()
        
        spyViewController = CreateEmployeeDisplayLogicSpy()
        sut.viewController = spyViewController
    }
    
    // MARK: Tests
    func testPresentSetupUI() {
        // Given
        let response = CreateEmployee.Texts.Response(title: "testTitle", nameTitle: "testNameTitle", salaryTitle: "testSalaryTitle", ageTitle: "testAgeTitle", buttonTitle: "testButtonTitle")
        // When
        sut.presentSetupUI(response: response)
        // Then
        XCTAssertTrue(spyViewController.displaySetupUICalled,"presentSetupUI should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displaySetupUIViewModel?.title,"testTitle")
        XCTAssertEqual(spyViewController.displaySetupUIViewModel?.nameTitle,"testNameTitle")
        XCTAssertEqual(spyViewController.displaySetupUIViewModel?.buttonTitle, "testButtonTitle")
    }
    func testPresentLoadingView() {
        // Given
        // When
        sut.presentLoadingView()
        // Then
        XCTAssertTrue(spyViewController.displayLoadingViewCalled, "presentLoadingView should ask the view controller to displayLoadingView")
    }
    func testHideLoadingView() {
        // Given
        // When
        sut.hideLoadingView()
        // Then
        XCTAssertTrue(spyViewController.hideLoadingViewCalled, "hideLoadingView should ask the view controller to hideLoadingView")
    }
    func testPresentErrorAlert() {
        // Given
        let response = CreateEmployee.Failure.Response(errorType: .internet)
        // When
        sut.presentErrorAlert(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayErrorAlertCalled, "presentErrorAlert should ask the view controller to displayErrorAlert")
        XCTAssertEqual(spyViewController.displayErrorAlertViewModel?.errorType, .internet, "the presenter should pass the response")
    }
    func testPresentButtonState() {
        // Given
        let response = CreateEmployee.EvaluateState.Response(activateButton: true)
        // When
        sut.presentButtonState(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayButtonStateCalled)
        XCTAssertEqual(spyViewController.displayButtonStateViewModel?.activateButton, true)
    }
    func testPresentData() {
        // Given
        let data = CreateEmployeeModel.Datum(name: "testname", salary: "1234", age: "12", id: 1)
        let response = CreateEmployee.Base.Response(data: data, name: "testName", salary: "1234", age: "12", id: 123)
        // When
        sut.presentData(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDataCalled)
        XCTAssertEqual(spyViewController.displayDataViewModel?.title, "Success!! Added testName")
    }
    
}
