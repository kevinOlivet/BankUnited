//
//  CreateEmployeeWorkerTests.swift
//  BankUnited
//
//

import BasicCommons
import OHHTTPStubs
@testable import BankUnited
import XCTest

class CreateEmployeeWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: CreateEmployeeWorker!
    var reachabilitySpy: ReachabilityCheckingProtocol?
    let stubs = BankUnitedStubs(logging: true, verbose: true)

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        setupCreateEmployeeWorker()
    }
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupCreateEmployeeWorker() {
        sut = CreateEmployeeWorker()
        stubs.removeAllStubs()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Tests
    func testGetDataSuccess() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.createEmployee,
            jsonFile: "POST_create_employee_200.json",
            stubName: "Create Employee stub",
            downloadSpeed: OHHTTPStubsDownloadSpeedWifi,
            responseTime: 0
        )

        let expectation = self.expectation(description: "calls the callback with a resource object")
        // When
        sut.postData(name: "Jon Olivet", salary: "123", age: "12", successCompletion: { dataResult in
            // Then
            XCTAssertEqual(
                dataResult?.data.name,
                "Kevin",
                "should match the JSON file"
            )
            expectation.fulfill()
        }) { _, _ in
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Create Employee stub")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetDataFail() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.createEmployee,
            jsonFile: "POST_create_employee_200.json",
            stubName: "Create Employee stub (general error)",
            responseTime: 1,
            failWithInternetError: true
        )

        let expectation = self.expectation(description: "network down")

        // When
        sut.postData(name: "Jon Olivet", salary: "123", age: "12", successCompletion: { _ in
        }) { error, statusCode in
            // Then
            XCTAssertNotNil(
                error,
                "no internet error returns an error"
            )
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Create Employee stub (general error)")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetDataNoInternet() {
        // Given
        let reachabilitySpy = ReachabilitySpy()
        reachabilitySpy.isConnectedToNetworkReturnValue = false
        sut.reachability = reachabilitySpy

        let expectation = self.expectation(description: "network is down!")

        // When
        sut.postData(name: "Jon Olivet", salary: "123", age: "12", successCompletion: { _ in
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
