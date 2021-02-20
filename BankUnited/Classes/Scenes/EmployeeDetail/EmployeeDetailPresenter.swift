//
//  EmployeeDetailPresenter.swift
//  BankUnited
//
//

import UIKit

protocol EmployeeDetailPresentationLogic {
    func presentSetupUI(response: EmployeeDetail.Texts.Response)
    func presentLoadingView()
    func hideLoadingView()
    func presentErrorAlert(response: EmployeeDetail.Failure.Response)
    func presentData(response: EmployeeDetail.Base.Response)
}

class EmployeeDetailPresenter: EmployeeDetailPresentationLogic {

    weak  var viewController: EmployeeDetailDisplayLogic?

    // MARK: Methods
    func presentSetupUI(response: EmployeeDetail.Texts.Response) {
        let viewModel = EmployeeDetail.Texts.ViewModel(
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
    func presentErrorAlert(response: EmployeeDetail.Failure.Response) {
        let viewModel = EmployeeDetail.Failure.ViewModel(errorType: response.errorType)
        viewController?.displayErrorAlert(viewModel: viewModel)
    }
    func presentData(response: EmployeeDetail.Base.Response) {
        let viewModel = EmployeeDetail.Base.ViewModel(
            name: response.data.employeeName,
            salary: "CURRENCY_SIGN".localized + String(response.data.employeeSalary),
            age: String(response.data.employeeAge)
        )
        viewController?.displayData(viewModel: viewModel)
    }

}
