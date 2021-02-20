//
//  BankUnitedLandingViewControllerTests.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited
import XCTest

class BankUnitedLandingViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: BankUnitedLandingViewController!
    var spyInteractor: BankUnitedLandingBusinessLogicSpy!
    var spyRouter: BankUnitedLandingRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupBankUnitedLandingViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupBankUnitedLandingViewController() {
        sut = BankUnitedLandingViewController()

        spyInteractor = BankUnitedLandingBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = BankUnitedLandingRoutingLogicSpy()
        sut.router = spyRouter

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

     func testViewDidLoad() {
        // Given
        // When
        // Then
        XCTAssertNotNil(
            sut,
            "the view should instantiate correctly"
        )
        XCTAssertTrue(
            spyInteractor.setupUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
    }
    func testRequiredInit() {
        // Given
        sut = nil
        XCTAssertNil(
            sut,
            "setting the sut to nil to test its other init"
        )
        // When
        let archiver = NSKeyedUnarchiver(forReadingWith: Data())
        sut = BankUnitedLandingViewController(coder: archiver)
        // Then
        XCTAssertNotNil(
            sut,
            "sut instantiated using the overrideInit"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = BankUnitedLanding.Basic.ViewModel(
            title: "testTitle",
            subtitle: "testSubtitle"
        )
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleLabelText,
            "testTitle",
            "should set the title correctly"
        )
        XCTAssertEqual(
            sut.subtitleLabelText,
            "testSubtitle",
            "should set the subtitle correctly"
        )
    }
    func testGoToEmployeesList() {
        // Given
        // When
        sut.goToEmployeesList()
        // Then
        XCTAssertTrue(
            spyRouter.routeToEmployeesListCalled,
            "goToEmployeesList should call router routeToEmployeesList"
        )
    }
}
