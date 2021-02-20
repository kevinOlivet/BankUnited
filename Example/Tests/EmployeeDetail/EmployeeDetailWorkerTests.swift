//
//  EmployeeDetailWorkerTests.swift
//  BankUnited
//
//

import BasicCommons
import OHHTTPStubs
@testable import BankUnited
import XCTest

class EmployeeDetailWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeeDetailWorker!
    var reachabilitySpy: ReachabilityCheckingProtocol?
    let stubs = BankUnitedStubs(logging: true, verbose: true)

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupEmployeeDetailWorker()
    }
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeeDetailWorker() {
        sut = EmployeeDetailWorker()
        stubs.removeAllStubs()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Tests
    func testGetDataSuccess() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.employeeDetail + "1",
            jsonFile: "GET_employee_details_200.json",
            stubName: "Employees detail stub",
            downloadSpeed: OHHTTPStubsDownloadSpeedWifi,
            responseTime: 0
        )

        let expectation = self.expectation(description: "calls the callback with a resource object")
        // When
        sut.getData(selectedEmployeeId: "1", successCompletion: { dataResult in
            // Then
            XCTAssertEqual(
                dataResult?.data.employeeName,
                "Jon Olivet",
                "should match the JSON file"
            )
            expectation.fulfill()
        }) { error, statusCode in
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Employees detail stub")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetDataFail() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.employeeDetail + "1",
            jsonFile: "GET_employee_details_200.json",
            stubName: "Employees details Stub (general error)",
            responseTime: 1,
            failWithInternetError: true
        )

        let expectation = self.expectation(description: "network down")

        // When
        sut.getData(selectedEmployeeId: "1", successCompletion: { _ in
        }) { error, statusCode in
            // Then
            XCTAssertNotNil(
                error,
                "no internet error returns an error"
            )
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Employees details Stub (general error)")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetDataNoInternet() {
        // Given
        let reachabilitySpy = ReachabilitySpy()
        reachabilitySpy.isConnectedToNetworkReturnValue = false
        sut.reachability = reachabilitySpy

        let expectation = self.expectation(description: "network is down!")

        // When
        sut.getData(selectedEmployeeId: "1", successCompletion: { _ in
        }) { error, statusCode in
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
