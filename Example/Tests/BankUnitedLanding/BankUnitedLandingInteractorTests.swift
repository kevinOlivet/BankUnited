//
//  BankUnitedLandingInteractorTests.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited
import XCTest

class BankUnitedLandingInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: BankUnitedLandingInteractor!
    var spyPresenter: BankUnitedLandingPresentationLogicSpy!
    var spyWorker: BankUnitedLandingWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupBankUnitedLandingInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupBankUnitedLandingInteractor() {
        sut = BankUnitedLandingInteractor()

        spyPresenter = BankUnitedLandingPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = BankUnitedLandingWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    class BankUnitedLandingWorkerSpy: BankUnitedLandingWorker {}

    // MARK: Tests

     func testSetupUI() {
        // Given
        let request = BankUnitedLanding.Basic.Request()
        // When
        sut.setupUI(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentSetupUICalled,
            "setupUI should ask the presenter to format the result"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.title,
            "WELCOME_TITLE",
            "setupUI should pass the title to the presenter"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.subtitle,
            "WELCOME_SUBTITLE",
            "setupUI should pass the subtitle to the presenter"
        )
    }

}
