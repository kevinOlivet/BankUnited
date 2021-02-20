//
//  EmployeesListViewController.swift
//  Pods
//
//

import BasicCommons
import BasicUIElements

protocol EmployeesListDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: EmployeesList.Texts.ViewModel)
    func displayLoadingView()
    func hideLoadingView()
    func displayErrorAlert(viewModel: EmployeesList.Failure.ViewModel)
    func displayEmployeesArray(viewModel: EmployeesList.Employees.ViewModel)
    func showEmployeeDetail(viewModel: EmployeesList.EmployeeDetails.ViewModel)}

class EmployeesListViewController: BaseViewController, EmployeesListDisplayLogic, UITableViewDataSource, UITableViewDelegate {

    var interactor: EmployeesListBusinessLogic?
    var router: (NSObjectProtocol & EmployeesListRoutingLogic & EmployeesListDataPassing)?

    var employeesToDisplay = [EmployeesList.Employees.ViewModel.DisplayEmployeesSuccess]()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var createEmployeeButton: UIButton!

    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = EmployeesListInteractor()
        let presenter = EmployeesListPresenter()
        let router = EmployeesListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    override  func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.prepareSetUpUI(request: EmployeesList.Texts.Request())
        fetchEmployeesList()
    }

    // MARK: Methods
    @objc
    func fetchEmployeesList() {
        genericHideErrorView()
        interactor?.fetchEmployeesList(request: EmployeesList.Employees.Request())
    }
    func displaySetupUI(viewModel: EmployeesList.Texts.ViewModel) {
        self.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.stop,
            target: self,
            action: #selector(closeButtonTapped)
        )
        createEmployeeButton.titleLabel?.text = viewModel.buttonTitle
        createEmployeeButton.addTapAction(target: self, action: #selector(showCreateNewEmployee))
        createEmployeeButton.setStyle(.basic)
    }
    @objc
    func closeButtonTapped() {
        genericHideErrorView()
        router?.closeToDashboard()
    }
    func displayLoadingView() {
        genericDisplayLoadingView()
    }
    func hideLoadingView() {
        genericHideLoadingView()
    }
    func displayErrorAlert(viewModel: EmployeesList.Failure.ViewModel) {
        genericDisplayErrorView(
            typeOfError: viewModel.errorType,
            retryAction: #selector(fetchEmployeesList),
            closeAction: #selector(closeButtonTapped)
        )
    }
    func displayEmployeesArray(viewModel: EmployeesList.Employees.ViewModel) {
        employeesToDisplay = viewModel.displayEmployeesArray
        tableView.reloadData()
    }
    func showEmployeeDetail(viewModel: EmployeesList.EmployeeDetails.ViewModel) {
        router?.routeToEmployeeDetail()
    }
    @objc
    func showCreateNewEmployee() {
        router?.routeToCreateNewEmployee()
    }
    // TableView setUp
    private static let cellIdentifier = "EmployeeTableViewCell"
    private func setupTableView() {
        let cellIdentifier = type(of: self).cellIdentifier
        let bundle = Utils.bundle(forClass: type(of: self).classForCoder())
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesToDisplay.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: type(of: self).cellIdentifier,
            for: indexPath
        ) as? EmployeeTableViewCell else {
            return UITableViewCell()
        }
        let employee = employeesToDisplay[indexPath.row]
        cell.objectVM = employee
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = EmployeesList.EmployeeDetails.Request(indexPath: indexPath.row)
        interactor?.handleDidSelectRow(request: request)
    }

    // MARK: - GettersSetters
    var titleText: String? { self.title }
    var getTableView: UITableView { tableView }
    var createEmployeeButtonText: String? { createEmployeeButton.titleLabel?.text }

}
