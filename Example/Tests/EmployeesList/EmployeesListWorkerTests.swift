//
//  EmployeesListWorkerTests.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited
import BasicCommons
import OHHTTPStubs
import XCTest

class EmployeesListWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeesListWorker!
    var reachabilitySpy: ReachabilityCheckingProtocol?
    let stubs = BankUnitedStubs(logging: true, verbose: true)

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupEmployeesListWorker()
    }
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeesListWorker() {
        sut = EmployeesListWorker()
        stubs.removeAllStubs()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Tests
    func testGetEmployeesListSuccess() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.employeesList,
            jsonFile: "GET_employees_list_200.json",
            stubName: "Employees list stub",
            downloadSpeed: OHHTTPStubsDownloadSpeedWifi,
            responseTime: 0
        )

        let expectation = self.expectation(description: "calls the callback with a resource object")
        // When
        sut.getEmployeesList(successCompletion: { employeesResult in
            // Then
            XCTAssertEqual(
                employeesResult?.data.first?.employeeName,
                "Tiger Nixon",
                "should match the JSON file"
            )
            XCTAssertEqual(
                employeesResult?.data.first?.id,
                "1",
                "should match the JSON file"
            )
            XCTAssertEqual(
                employeesResult?.data.first?.employeeAge,
                "61",
                "should match the JSON file"
            )
            XCTAssertEqual(
                employeesResult?.data.first?.employeeSalary,
                "320800",
                "should match the JSON file"
            )
            expectation.fulfill()
        }) { _ in
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Employees list stub")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetEmployeesListFail() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.employeesList,
            jsonFile: "GET_employees_list_200.json",
            stubName: "Employees list Stub (general error)",
            responseTime: 1,
            failWithInternetError: true
        )

        let expectation = self.expectation(description: "network down")

        // When
        sut.getEmployeesList(successCompletion: { _ in
        }) { error in
            // Then
            XCTAssertNotNil(
                error,
                "no internet error returns an error"
            )
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Employees list Stub (general error)")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetEmployeesListNoInternet() {
        // Given
        let reachabilitySpy = ReachabilitySpy()
        reachabilitySpy.isConnectedToNetworkReturnValue = false
        sut.reachability = reachabilitySpy

        let expectation = self.expectation(description: "network is down!")

        // When
        sut.getEmployeesList(successCompletion: { _ in
        }) { error in
            switch error {
            case NTError.noInternetConection:
                expectation.fulfill()
                return

            default:
                return
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
}
