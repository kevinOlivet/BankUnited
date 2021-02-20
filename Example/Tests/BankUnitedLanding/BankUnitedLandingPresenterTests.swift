//
//  BankUnitedLandingPresenterTests.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited
import XCTest

class BankUnitedLandingPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: BankUnitedLandingPresenter!
    var spyViewController: BankUnitedLandingDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupBankUnitedLandingPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupBankUnitedLandingPresenter() {
        sut = BankUnitedLandingPresenter()

        spyViewController = BankUnitedLandingDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

     func testPresentSetupUI() {
        // Given
        let response = BankUnitedLanding.Basic.Response(
            title: "WELCOME_TITLE",
            subtitle: "WELCOME_TITLE"
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
            "WELCOME_TITLE".localized,
            "presentMovements should localize the title"
        )
        XCTAssertEqual(
            spyViewController.displaySetupUIViewModel?.subtitle,
            "WELCOME_TITLE".localized,
            "presentMovements should localize the subtitle"
        )
    }
}
