//
//  EmployeesListPresenterTests.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited
import XCTest

class EmployeesListPresenterTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeesListPresenter!
    var spyViewController: EmployeesListDisplayLogicSpy!

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupEmployeesListPresenter()
    }
    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeesListPresenter() {
        sut = EmployeesListPresenter()

        spyViewController = EmployeesListDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

    func testPresentSetupUI() {
       // Given
        let response = EmployeesList.Texts.Response(
            title: "testtitle",
            buttonTitle: "testbuttonTitle"
        )
       // When
       sut.presentSetupUI(response: response)
       // Then
       XCTAssertTrue(
           spyViewController.displaySetupUICalled,
           "presentSetupUI should ask the view controller to display the result"
       )
       XCTAssertEqual(
           spyViewController.displaySetupUIViewModel?.title,
           "testtitle"
       )
        XCTAssertEqual(
            spyViewController.displaySetupUIViewModel?.buttonTitle,
            "testbuttonTitle"
        )
   }
   func testPresentLoadingView() {
       // Given
       // When
       sut.presentLoadingView()
       // Then
       XCTAssertTrue(
           spyViewController.displayLoadingViewCalled,
           "presentLoadingView should ask the view controller to displayLoadingView"
       )
   }
   func testHideLoadingView() {
       // Given
       // When
       sut.hideLoadingView()
       // Then
       XCTAssertTrue(
           spyViewController.hideLoadingViewCalled,
           "hideLoadingView should ask the view controller to hideLoadingView"
       )
   }
   func testPresentErrorAlert() {
       // Given
       let response = EmployeesList.Failure.Response(errorType: .internet)
       // When
       sut.presentErrorAlert(response: response)
       // Then
       XCTAssertTrue(
           spyViewController.displayErrorAlertCalled,
           "presentErrorAlert should ask the view controller to displayErrorAlert"
       )
       XCTAssertEqual(
           spyViewController.displayErrorAlertViewModel?.errorType,
           .internet,
           "the presenter should pass the response"
       )
   }
    func testPresentEmployeesList() {
        // Given
        let data = EmployeesModel.Datum(
            id: 1233,
            employeeSalary: 12,
            employeeAge: 123,
            employeeName: "testemployeeName"
        )
        let response = EmployeesList.Base.Response(employeesArray: [data])
        // When
        sut.presentEmployeesList(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayEmployeesArrayCalled)
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.nameTitle, "Name")
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.name, "testemployeeName")
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.salaryTitle, "Salary")
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.salary, "$ 12")
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.ageTitle, "Age")
        XCTAssertEqual(spyViewController.displayEmployeesArrayViewModel?.displayEmployeesArray.first?.age, "123")
    }
    func testPresentEmployeeDetail() {
        // Given
        let response = EmployeesList.EmployeeDetails.Response()
        // When
        sut.presentEmployeeDetail(response: response)
        // Then
        XCTAssertTrue(spyViewController.showEmployeeDetailCalled)
    }

}
