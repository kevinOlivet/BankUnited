//
//  EmployeesListInteractor.swift
//  Pods
//
//

import Foundation

protocol EmployeesListBusinessLogic {
    func prepareSetUpUI(request: EmployeesList.Texts.Request)
    func fetchEmployeesList(request: EmployeesList.Base.Request)
    func handleDidSelectRow(request: EmployeesList.EmployeeDetails.Request)
}

protocol EmployeesListDataStore {
    var selectedEmployeeId: Int! { get set }
}

class EmployeesListInteractor: EmployeesListBusinessLogic, EmployeesListDataStore {
    var presenter: EmployeesListPresentationLogic?
    var worker: EmployeesListWorker? = EmployeesListWorker()
    var selectedEmployeeId: Int!

    // MARK: Methods

    func prepareSetUpUI(request: EmployeesList.Texts.Request) {
        let response = EmployeesList.Texts.Response(
            title: "EMPLOYEES",
            buttonTitle: "CREATE_NEW_EMPLOYEEE"
        )
        presenter?.presentSetupUI(response: response)
    }

    func fetchEmployeesList(request: EmployeesList.Base.Request) {
        presenter?.presentLoadingView()

        worker?.getEmployeesList(successCompletion: { (receivedEmployees) in
            self.presenter?.hideLoadingView()
            if let receivedEmployees = receivedEmployees {
                let response = EmployeesList.Base.Response(employeesArray: receivedEmployees.data)
                self.presenter?.presentEmployeesList(response: response)
            } else {
                let response = EmployeesList.Failure.Response(errorType: .service)
                self.presenter?.presentErrorAlert(response: response)
            }

        }) { (_) in
            self.presenter?.hideLoadingView()
            let response = EmployeesList.Failure.Response(errorType: .internet)
            self.presenter?.presentErrorAlert(response: response)
        }
    }

    func handleDidSelectRow(request: EmployeesList.EmployeeDetails.Request) {
        selectedEmployeeId = request.indexPath
        let response = EmployeesList.EmployeeDetails.Response()
        presenter?.presentEmployeeDetail(response: response)
    }
}
