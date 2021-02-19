//
//  BankUnitedLandingViewController.swift
//  Pods
//
//  Copyright Jon Kevin Olivet
//

import BasicCommons
import BasicUIElements
import Lottie

protocol BankUnitedLandingDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: BankUnitedLanding.Basic.ViewModel)
}

class BankUnitedLandingViewController: BaseViewController, BankUnitedLandingDisplayLogic {
    var interactor: BankUnitedLandingBusinessLogic?
    var router: (NSObjectProtocol & BankUnitedLandingRoutingLogic & BankUnitedLandingDataPassing)?

    var animation: MainAnimationView?

    @IBOutlet private weak var welcomeView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    init() {
        let bundleToUse = Utils.bundle(forClass: BankUnitedLandingViewController.classForCoder())
        super.init(nibName: "BankUnitedLandingViewController", bundle: bundleToUse)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = BankUnitedLandingInteractor()
        let presenter = BankUnitedLandingPresenter()
        let router = BankUnitedLandingRouter()
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
        interactor?.setupUI(request: BankUnitedLanding.Basic.Request())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation?.play()
    }

    // MARK: Methods
    func displaySetupUI(viewModel: BankUnitedLanding.Basic.ViewModel) {
        view.addTapAction(target: self, action: #selector(goToEmployeesList))
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        animation = WelcomeAnimation(
            width: welcomeView.frame.size.width,
            height: welcomeView.frame.size.height
        )
        welcomeView.addSubview(animation!)
    }

    @objc
    func goToEmployeesList() {
        router?.routeToEmployeesList()
    }

    // Getters
    var titleLabelText: String? { titleLabel.text }
    var subtitleLabelText: String? { subtitleLabel.text }
}
