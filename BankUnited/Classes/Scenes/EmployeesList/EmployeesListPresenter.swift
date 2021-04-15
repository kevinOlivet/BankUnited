//
//  EmployeesListPresenter.swift
//  Pods
//
//

import UIKit

protocol EmployeesListPresentationLogic {
    func presentSetupUI(response: EmployeesList.Texts.Response)
    func presentLoadingView()
    func hideLoadingView()
    func presentErrorAlert(response: EmployeesList.Failure.Response)
    func presentEmployeesList(response: EmployeesList.Base.Response)
    func presentEmployeeDetail(response: EmployeesList.EmployeeDetails.Response)
}

class EmployeesListPresenter: EmployeesListPresentationLogic {
    weak  var viewController: EmployeesListDisplayLogic?

    // MARK: Methods
    func presentSetupUI(response: EmployeesList.Texts.Response) {
        let viewModel = EmployeesList.Texts.ViewModel(
            title: response.title.localized(in: .BankUnited),
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
    func presentErrorAlert(response: EmployeesList.Failure.Response) {
        let viewModel = EmployeesList.Failure.ViewModel(errorType: response.errorType)
        viewController?.displayErrorAlert(viewModel: viewModel)
    }
    func presentEmployeesList(response: EmployeesList.Base.Response) {
        var employeeArray = [EmployeesList.Base.ViewModel.DisplayEmployeesSuccess]()
        for employee in response.employeesArray {
            let viewModel = EmployeesList.Base.ViewModel.DisplayEmployeesSuccess(
                nameTitle: "NAME".localized,
                name: employee.employeeName,
                salaryTitle: "SALARY".localized,
                salary: "CURRENCY_SIGN".localized + String(employee.employeeSalary),
                ageTitle: "AGE".localized,
                age: String(employee.employeeAge)
            )
            employeeArray.append(viewModel)
        }
        let viewModel = EmployeesList.Base.ViewModel(displayEmployeesArray: employeeArray)
        viewController?.displayEmployeesArray(viewModel: viewModel)
    }
    func presentEmployeeDetail(response: EmployeesList.EmployeeDetails.Response) {
        let viewModel = EmployeesList.EmployeeDetails.ViewModel()
        viewController?.showEmployeeDetail(viewModel: viewModel)
    }
}
