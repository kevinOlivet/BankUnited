//
//  CreateEmployeeViewController.swift
//  Pods
//
//

protocol CreateEmployeeDelegate: class {
    func reloadTheTable()
}

import BasicCommons
import BasicUIElements

protocol CreateEmployeeDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: CreateEmployee.Texts.ViewModel)
    func displayLoadingView()
    func hideLoadingView()
    func displayErrorAlert(viewModel: CreateEmployee.Failure.ViewModel)
    func displayButtonState(viewModel: CreateEmployee.EvaluateState.ViewModel)
    func displayData(viewModel: CreateEmployee.Base.ViewModel)
}

class CreateEmployeeViewController: BaseViewController, CreateEmployeeDisplayLogic, UITextFieldDelegate {
    
    var interactor: CreateEmployeeBusinessLogic?
    var router: (NSObjectProtocol & CreateEmployeeRoutingLogic & CreateEmployeeDataPassing)?
    weak var createEmployeeDelegate: CreateEmployeeDelegate?

    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var salaryTitleLabel: UILabel!
    @IBOutlet private weak var salaryTextField: UITextField!
    @IBOutlet private weak var ageTitleLabel: UILabel!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var submitEmployeeButton: UIButton!
    
    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CreateEmployeeInteractor()
        let presenter = CreateEmployeePresenter()
        let router = CreateEmployeeRouter()
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
        interactor?.prepareSetUpUI(request: CreateEmployee.Texts.Request())
    }
    
    // MARK: Methods
    @objc
    func sendData() {
        genericHideErrorView()
        interactor?.sendData(request: CreateEmployee.Base.Request())
    }
    func displaySetupUI(viewModel: CreateEmployee.Texts.ViewModel) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.stop,
            target: self,
            action: #selector(closeButtonTapped)
        )
        self.title = viewModel.title
        nameTitleLabel.text = viewModel.nameTitle
        salaryTitleLabel.text = viewModel.salaryTitle
        ageTitleLabel.text = viewModel.ageTitle
        submitEmployeeButton.titleLabel?.text = viewModel.buttonTitle
        submitEmployeeButton.addTapAction(target: self, action: #selector(sendData))
        submitEmployeeButton.setStyle(.disable)
    }
    func displayLoadingView() {
        genericDisplayLoadingView()
    }
    func hideLoadingView() {
        genericHideLoadingView()
    }
    func displayErrorAlert(viewModel: CreateEmployee.Failure.ViewModel) {
        genericDisplayErrorView(
            typeOfError: viewModel.errorType,
            retryAction: #selector(sendData),
            closeAction: #selector(closeButtonTapped)
        )
    }
    func displayButtonState(viewModel: CreateEmployee.EvaluateState.ViewModel) {
        let buttonStyle: UIButton.ButtonTypes = viewModel.activateButton == true ? .first : .disable
        submitEmployeeButton.setStyle(buttonStyle)
    }
    func displayData(viewModel: CreateEmployee.Base.ViewModel) {
        genericHideLoadingView()
        genericDisplaySuccessView(
            title: viewModel.title,
            message: viewModel.message,
            closeAction: #selector(goBackAndLoad)
        )
    }
    @objc
    func closeButtonTapped() {
        genericHideErrorView()
        router?.closeToDashboard()
    }
    @objc
    func goBackAndLoad() {
        genericHideSuccessView()
        router?.routeToBack()
        createEmployeeDelegate?.reloadTheTable()
    }

    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if textField == nameTextField {
            return newLength <= CreateEmployee.CharacterLimit.name.rawValue
        } else if textField == salaryTextField {
            return newLength <= CreateEmployee.CharacterLimit.salary.rawValue
        } else {
            return newLength <= CreateEmployee.CharacterLimit.age.rawValue
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let request = CreateEmployee.EvaluateState.Request(
            name: nameTextField.text,
            salary: salaryTextField.text,
            age: ageTextField.text
        )
        interactor?.evaluateState(request: request)
    }
    
    // MARK: - GettersSetters
    var titleText: String? { self.title }
    var nameTitleLabelText: String? { nameTitleLabel.text }
    var submitEmployeeButtonText: String? { submitEmployeeButton.titleLabel?.text }
    var submitEmployeeButtonEnabled: Bool { submitEmployeeButton.isEnabled }

    
}
