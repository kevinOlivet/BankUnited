//
//  EmployeeDetailPresenterTests.swift
//  BankUnited
//
//

@testable import BankUnited
import XCTest

class EmployeeDetailPresenterTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeeDetailPresenter!
    var spyViewController: EmployeeDetailDisplayLogicSpy!

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupEmployeeDetailPresenter()
    }
    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeeDetailPresenter() {
        sut = EmployeeDetailPresenter()

        spyViewController = EmployeeDetailDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

    func testPresentSetupUI() {
       // Given
        let response = EmployeeDetail.Texts.Response(
            title: "testTitle",
            nameTitle: "testnameTitle",
            salaryTitle: "testsalaryTitle",
            ageTitle: "testageTitle",
            buttonTitle: "testbuttonTitle"
        )
       // When
       sut.presentSetupUI(response: response)
       // Then
       XCTAssertTrue(spyViewController.displaySetupUICalled,"presentSetupUI should ask the view controller to display the result")
       XCTAssertEqual(spyViewController.displaySetupUIViewModel?.title,"testTitle")
        XCTAssertEqual(spyViewController.displaySetupUIViewModel?.buttonTitle, "testbuttonTitle")
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
       let response = EmployeeDetail.Failure.Response(errorType: .internet)
       // When
       sut.presentErrorAlert(response: response)
       // Then
       XCTAssertTrue(spyViewController.displayErrorAlertCalled, "presentErrorAlert should ask the view controller to displayErrorAlert")
       XCTAssertEqual(spyViewController.displayErrorAlertViewModel?.errorType, .internet, "the presenter should pass the response")
   }
    func testPresentData() {
        // Given
        let data = EmployeeDetailModel.Datum(
            id: 12,
            employeeName: "testemployeeName",
            employeeSalary: 123,
            employeeAge: 1234,
            profileImage: "testprofileImage"
        )
        let response = EmployeeDetail.Base.Response(data: data)
        // When
        sut.presentData(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDataCalled)
        XCTAssertEqual(spyViewController.displayDataViewModel?.name, "testemployeeName")
    }

}
