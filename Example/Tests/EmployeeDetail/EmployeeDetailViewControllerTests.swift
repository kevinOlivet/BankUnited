//
//  EmployeeDetailViewControllerTests.swift
//  BankUnited
//
//

@testable import BankUnited
import BasicCommons
import BasicUIElements
import XCTest

class EmployeeDetailViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: EmployeeDetailViewController!
    var spyInteractor: EmployeeDetailBusinessLogicSpy!
    var spyRouter: EmployeeDetailRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupEmployeeDetailViewController()
    }
    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupEmployeeDetailViewController() {
        let bundle = Utils.bundle(forClass: EmployeeDetailViewController.classForCoder())!
        let storyboard = UIStoryboard(name: "EmployeesMain", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController)

        spyInteractor = EmployeeDetailBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = EmployeeDetailRoutingLogicSpy()
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
            spyInteractor.prepareSetUpUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
        XCTAssertTrue(
            spyInteractor.fetchDataCalled,
            "viewDidLoad should call the interactor to fetch PaymentMethods"
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
        sut = EmployeeDetailViewController(coder: archiver)
        // Then
        XCTAssertNotNil(
            sut,
            "sut instantiated using the overrideInit"
        )
        XCTAssertTrue(
            spyInteractor.prepareSetUpUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
        XCTAssertTrue(
            spyInteractor.fetchDataCalled,
            "viewDidLoad should call the interactor to fetch PaymentMethods"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = EmployeeDetail.Texts.ViewModel(
            title: "testtitle",
            nameTitle: "testnameTitle",
            salaryTitle: "testsalaryTitle",
            ageTitle: "testageTitle",
            buttonTitle: "testbuttonTitle"
        )
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.nameTitleLabelText, "testnameTitle")
        XCTAssertEqual(sut.salaryTitleLabelText, "testsalaryTitle")
        XCTAssertEqual(sut.ageTitleLabelText, "testageTitle")
    }
    func testCloseButtonTapped() {
        // Given
        // When
        sut.closeButtonTapped()
        // Then
        XCTAssertTrue(spyRouter.closeToDashboardCalled)
    }
    func testGoBackTapped() {
        // Given
        // When
        sut.goBackTapped()
        // Then
        XCTAssertTrue(spyRouter.routeToBackCalled)
    }
    func testDisplayLoadingView() {
        // Given
        // When
        sut.displayLoadingView()
        // Then
        XCTAssertTrue(sut.view.subviews.last is MainActivityIndicator)
    }
    func testDisplayData() {
        // Given
        let viewModel = EmployeeDetail.Base.ViewModel(name: "testname", salary: "testsalary", age: "testage")
        // When
        sut.displayData(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.nameDisplayLabelText, "testname")
        XCTAssertEqual(sut.salaryDisplayLabelText, "testsalary")
        XCTAssertEqual(sut.ageDisplayLabelText, "testage")
    }
    func testDisplayErrorAlert() {
        // Given
        let viewModel = EmployeeDetail.Failure.ViewModel(errorType: .internet)
        // When
        sut.displayErrorAlert(viewModel: viewModel)
        // Then
        XCTAssertTrue(sut.view.subviews.last is FullScreenMessageErrorAnimated)
    }

}
