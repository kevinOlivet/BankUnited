//
//  CreateEmployeePresenter.swift
//  BankUnited
//
//

import UIKit

protocol CreateEmployeePresentationLogic {
    func presentSetupUI(response: CreateEmployee.Texts.Response)
    func presentLoadingView()
    func hideLoadingView()
    func presentErrorAlert(response: CreateEmployee.Failure.Response)
    func presentData(response: CreateEmployee.Base.Response)
    func presentButtonState(response: CreateEmployee.EvaluateState.Response)
}

class CreateEmployeePresenter: CreateEmployeePresentationLogic {
    
    weak  var viewController: CreateEmployeeDisplayLogic?
    
    // MARK: Methods
    func presentSetupUI(response: CreateEmployee.Texts.Response) {
        let viewModel = CreateEmployee.Texts.ViewModel(
            title: response.title.localized,
            nameTitle: response.nameTitle.localized,
            salaryTitle: response.salaryTitle.localized,
            ageTitle: response.ageTitle.localized,
            buttonTitle: response.buttonTitle.localized
        )
        viewController?.displaySetupUI(viewModel: viewModel)
    }
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
    func hideLoadingView() {
        viewController?.hideLoadingView()
    }
    func presentErrorAlert(response: CreateEmployee.Failure.Response) {
        let viewModel = CreateEmployee.Failure.ViewModel(errorType: response.errorType)
        viewController?.displayErrorAlert(viewModel: viewModel)
    }
    func presentButtonState(response: CreateEmployee.EvaluateState.Response) {
        let viewModel = CreateEmployee.EvaluateState.ViewModel(activateButton: response.activateButton)
        viewController?.displayButtonState(viewModel: viewModel)
    }
    func presentData(response: CreateEmployee.Base.Response) {
        let title = "SUCCESS".localized + "ADDED".localized + response.name
        let message = "SALARY".localized + ": " + response.salary + ". "
            + "AGE".localized + ": " + response.age + ". "
            + "ID".localized + ": " + String(response.id) + "."
        let viewModel = CreateEmployee.Base.ViewModel(
            title: title,
            message: message
            )
        viewController?.displayData(viewModel: viewModel)
    }
    
}
