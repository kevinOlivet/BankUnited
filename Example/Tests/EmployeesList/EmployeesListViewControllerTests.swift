//
//  EmployeesListViewControllerTests.swift
//  BankUnited
//
//  Created on 19-02-21.
//
//

@testable import BankUnited
import BasicCommons
import BasicUIElements
import XCTest

class EmployeesListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: EmployeesListViewController!
    var spyInteractor: EmployeesListBusinessLogicSpy!
    var spyRouter: EmployeesListRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupEmployeesListViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupEmployeesListViewController() {
        let bundle = Utils.bundle(forClass: EmployeesListViewController.classForCoder())!
        let storyboard = UIStoryboard(name: "EmployeesMain", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "EmployeesListViewController") as! EmployeesListViewController)

        spyInteractor = EmployeesListBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = EmployeesListRoutingLogicSpy()
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
            spyInteractor.fetchEmployeesListCalled,
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
        sut = EmployeesListViewController(coder: archiver)
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
            spyInteractor.fetchEmployeesListCalled,
            "viewDidLoad should call the interactor to fetch PaymentMethods"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = EmployeesList.Texts.ViewModel(title: "testTitle", buttonTitle: "testbuttonTitle")
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleText,
            "testTitle",
            "displaySetUpUI should set the title correctly"
        )
        XCTAssertEqual(sut.createEmployeeButtonText, "testbuttonTitle")
    }
    func testCloseButtonTapped() {
        // Given
        // When
        sut.closeButtonTapped()
        // Then
        XCTAssertTrue(spyRouter.closeToDashboardCalled)
    }
    func testDisplayLoadingView() {
        // Given
        // When
        sut.displayLoadingView()
        // Then
        XCTAssertTrue(sut.view.subviews.last is MainActivityIndicator)
    }
    func testDisplayEmployeesArray() {
        // Given
        let data = EmployeesList.Employees.ViewModel.DisplayEmployeesSuccess(
            nameTitle: "testnameTitle",
            name: "testname",
            salaryTitle: "testsalaryTitle",
            salary: "testsalary",
            ageTitle: "testageTitle",
            age: "testage"
        )
        let viewModel = EmployeesList.Employees.ViewModel(displayEmployeesArray: [data])
        // When
        sut.displayEmployeesArray(viewModel: viewModel)
        // Then
        XCTAssertEqual(sut.employeesToDisplay.first?.name, "testname")
    }
    func testDisplayErrorAlert() {
        // Given
        let viewModel = EmployeesList.Failure.ViewModel(errorType: .internet)
        // When
        sut.displayErrorAlert(viewModel: viewModel)
        // Then
        XCTAssertTrue(sut.view.subviews.last is FullScreenMessageErrorAnimated)
    }
    func testShowEmployeeDetail() {
        // Given
        let viewModel = EmployeesList.EmployeeDetails.ViewModel()
        // When
        sut.showEmployeeDetail(viewModel: viewModel)
        // Then
        XCTAssertTrue(spyRouter.routeToEmployeeDetailCalled)
    }
    func testShowCreateNewEmployee() {
        // Given
        // When
        sut.showCreateNewEmployee()
        // Then
        XCTAssertTrue(spyRouter.routeToCreateNewEmployeeCalled)
    }
    func testCellForRow() {
        // Given
        let data = EmployeesList.Employees.ViewModel.DisplayEmployeesSuccess(
            nameTitle: "testnameTitle",
            name: "testname",
            salaryTitle: "testsalaryTitle",
            salary: "testsalary",
            ageTitle: "testageTitle",
            age: "testage"
        )
        let viewModel = EmployeesList.Employees.ViewModel(displayEmployeesArray: [data])

        sut.employeesToDisplay = viewModel.displayEmployeesArray
        sut.getTableView.reloadData()
        let indexPathToUse = IndexPath(row: 0, section: 0)
        // When
        let cell = sut.tableView(sut.getTableView, cellForRowAt: indexPathToUse)
        XCTAssertTrue(cell is EmployeeTableViewCell, "cell should be PaymentMethodTableViewCell")
        guard let employeeCell = cell as? EmployeeTableViewCell else {
            XCTFail("cell is not EmployeeTableViewCell")
            return
        }
        XCTAssertEqual(
            employeeCell.nameDisplayLabelText,
            "testname",
            "should equal the name passed to the cell"
        )
    }
}
