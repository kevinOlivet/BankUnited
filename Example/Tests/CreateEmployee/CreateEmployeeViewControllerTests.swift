//
//  CreateEmployeeViewControllerTests.swift
//  BankUnited
//
//

@testable import BankUnited
import BasicCommons
import BasicUIElements
import XCTest

class CreateEmployeeViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: CreateEmployeeViewController!
    var spyInteractor: CreateEmployeeBusinessLogicSpy!
    var spyRouter: CreateEmployeeRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupCreateEmployeeViewController()
    }
    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupCreateEmployeeViewController() {
        let bundle = Utils.bundle(forClass: CreateEmployeeViewController.classForCoder())!
        let storyboard = UIStoryboard(name: "EmployeesMain", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "CreateEmployeeViewController") as! CreateEmployeeViewController)
        
        spyInteractor = CreateEmployeeBusinessLogicSpy()
        sut.interactor = spyInteractor
        
        spyRouter = CreateEmployeeRoutingLogicSpy()
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
        sut = CreateEmployeeViewController(coder: archiver)
        // Then
        XCTAssertNotNil(
            sut,
            "sut instantiated using the overrideInit"
        )
        XCTAssertTrue(
            spyInteractor.prepareSetUpUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
    }
    func testSendData() {
        // Given
        // When
        sut.sendData()
        // Then
        XCTAssertTrue(spyInteractor.sendDataCalled)
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = CreateEmployee.Texts.ViewModel(title: "testtitle", nameTitle: "testnameTitle", salaryTitle: "testsalaryTitle", ageTitle: "testageTitle", buttonTitle: "testbuttonTitle")
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleText,
            "testtitle",
            "displaySetUpUI should set the title correctly"
        )
        XCTAssertEqual(sut.nameTitleLabelText, "testnameTitle")
        XCTAssertEqual(sut.submitEmployeeButtonText, "testbuttonTitle")
    }
    func testCloseButtonTapped() {
        // Given
        // When
        sut.closeButtonTapped()
        // Then
        XCTAssertTrue(spyRouter.closeToDashboardCalled)
    }
    func testGoBackAndLoad() {
        // Given
        // When
        sut.goBackAndLoad()
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
        let viewModel = CreateEmployee.Base.ViewModel(title: "testtitle", message: "testmessage")
        // When
        sut.displayData(viewModel: viewModel)
        // Then
        XCTAssertTrue(sut.view.subviews.last is FullScreenMessageErrorAnimated)
    }
    func testDisplayErrorAlert() {
        // Given
        let viewModel = CreateEmployee.Failure.ViewModel(errorType: .internet)
        // When
        sut.displayErrorAlert(viewModel: viewModel)
        // Then
        XCTAssertTrue(sut.view.subviews.last is FullScreenMessageErrorAnimated)
    }
    func testDisplayButtonState() {
        // Given
        let viewModel = CreateEmployee.EvaluateState.ViewModel(activateButton: true)
        // When
        sut.displayButtonState(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.submitEmployeeButtonEnabled, true)
    }
    
}
