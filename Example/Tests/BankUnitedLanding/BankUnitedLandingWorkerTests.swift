//
//  BankUnitedLandingWorkerTests.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable force_cast
// swiftlint:disable identifier_name
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable line_length

//import Commons
//import OHHTTPStubs
@testable import BankUnited
import XCTest

class BankUnitedLandingWorkerTests: XCTestCase {
    // MARK: Subject under test

    var sut: BankUnitedLandingWorker!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupBankUnitedLandingWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupBankUnitedLandingWorker() {
        sut = BankUnitedLandingWorker()
    }

    // MARK: Tests
    // nothing to test here yet
}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
