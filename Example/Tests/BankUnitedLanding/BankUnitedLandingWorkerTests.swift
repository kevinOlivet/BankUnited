//
//  BankUnitedLandingWorkerTests.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

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
