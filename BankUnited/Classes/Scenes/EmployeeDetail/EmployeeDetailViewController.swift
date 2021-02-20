//
//  EmployeeDetailViewController.swift
//  BankUnited
//
//

import BasicCommons
import BasicUIElements

protocol EmployeeDetailDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: EmployeeDetail.Texts.ViewModel)
    func displayLoadingView()
    func hideLoadingView()
    func displayErrorAlert(viewModel: EmployeeDetail.Failure.ViewModel)
    func displayData(viewModel: EmployeeDetail.Base.ViewModel)
}

class EmployeeDetailViewController: BaseViewController, EmployeeDetailDisplayLogic{

    var interactor: EmployeeDetailBusinessLogic?
    var router: (NSObjectProtocol & EmployeeDetailRoutingLogic & EmployeeDetailDataPassing)?

    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameDisplayLabel: UILabel!
    @IBOutlet private weak var salaryTitleLabel: UILabel!
    @IBOutlet private weak var salaryDisplayLabel: UILabel!
    @IBOutlet private weak var ageTitleLabel: UILabel!
    @IBOutlet private weak var ageDisplayLabel: UILabel!
    @IBOutlet private weak var goBackButton: UIButton!

    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = EmployeeDetailInteractor()
        let presenter = EmployeeDetailPresenter()
        let router = EmployeeDetailRouter()
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
        interactor?.prepareSetUpUI(request: EmployeeDetail.Texts.Request())
        fetchData()
    }

    // MARK: Methods
    @objc
    func fetchData() {
        genericHideErrorView()
        interactor?.fetchData(request: EmployeeDetail.Base.Request())
    }
    func displaySetupUI(viewModel: EmployeeDetail.Texts.ViewModel) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.stop,
            target: self,
            action: #selector(closeButtonTapped)
        )
        self.title = viewModel.title
        nameTitleLabel.text = viewModel.nameTitle
        salaryTitleLabel.text = viewModel.salaryTitle
        ageTitleLabel.text = viewModel.ageTitle
        goBackButton.titleLabel?.text = viewModel.buttonTitle
        goBackButton.addTapAction(target: self, action: #selector(goBackTapped))
        goBackButton.setStyle(.basic)
    }
    func displayLoadingView() {
        genericDisplayLoadingView()
    }
    func hideLoadingView() {
        genericHideLoadingView()
    }
    func displayErrorAlert(viewModel: EmployeeDetail.Failure.ViewModel) {
        genericDisplayErrorView(
            typeOfError: viewModel.errorType,
            retryAction: #selector(fetchData),
            closeAction: #selector(closeButtonTapped)
        )
    }
    func displayData(viewModel: EmployeeDetail.Base.ViewModel) {
        nameDisplayLabel.text = viewModel.name
        salaryDisplayLabel.text = viewModel.salary
        ageDisplayLabel.text = viewModel.age
    }
    @objc
    func closeButtonTapped() {
        genericHideErrorView()
        router?.closeToDashboard()
    }
    @objc
    func goBackTapped() {
        genericHideErrorView()
        router?.routeToBack()
    }

    // MARK: - GettersSetters
    var nameTitleLabelText: String? { nameTitleLabel.text }
    var nameDisplayLabelText: String? { nameDisplayLabel.text }
    var salaryTitleLabelText: String? { salaryTitleLabel.text }
    var salaryDisplayLabelText: String? { salaryDisplayLabel.text }
    var ageTitleLabelText: String? { ageTitleLabel.text }
    var ageDisplayLabelText: String? { ageDisplayLabel.text }
    var goBackButtonText: String? { goBackButton.titleLabel?.text }

}
