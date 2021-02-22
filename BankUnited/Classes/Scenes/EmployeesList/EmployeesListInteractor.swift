//
//  EmployeesListInteractor.swift
//  Pods
//
//

import BasicCommons

protocol EmployeesListBusinessLogic {
    func prepareSetUpUI(request: EmployeesList.Texts.Request)
    func fetchEmployeesList(request: EmployeesList.Base.Request)
    func handleDidSelectRow(request: EmployeesList.EmployeeDetails.Request)
}

protocol EmployeesListDataStore {
    var selectedEmployeeId: String! { get set }
    var selectedEmployeeName: String! { get set }
}

class EmployeesListInteractor: EmployeesListBusinessLogic, EmployeesListDataStore {
    var presenter: EmployeesListPresentationLogic?
    var worker: EmployeesListWorker = EmployeesListWorker()
    var foundEmployees = [EmployeesModel.Datum]()
    var selectedEmployeeId: String!
    var selectedEmployeeName: String!

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

        worker.getEmployeesList(
            successCompletion: { [weak self] (receivedEmployees) in
                self?.presenter?.hideLoadingView()
                if let receivedEmployees = receivedEmployees {
                    self?.foundEmployees.removeAll()
                    self?.foundEmployees = receivedEmployees.data
                    let response = EmployeesList.Base.Response(employeesArray: receivedEmployees.data)
                    self?.presenter?.presentEmployeesList(response: response)
                } else {
                    let response = EmployeesList.Failure.Response(errorType: .service)
                    self?.presenter?.presentErrorAlert(response: response)
                }

            }) { (error, statusCode) in
            self.presenter?.hideLoadingView()
            if statusCode == ErrorCode.tooManyRequests.rawValue {
                let response = EmployeesList.Failure.Response(errorType: .tooManyRequests)
                self.presenter?.presentErrorAlert(response: response)
            } else {
                let response = EmployeesList.Failure.Response(errorType: .internet)
                self.presenter?.presentErrorAlert(response: response)
            }
        }
    }

    func handleDidSelectRow(request: EmployeesList.EmployeeDetails.Request) {
        selectedEmployeeId = foundEmployees[request.indexPath].id
        selectedEmployeeName = foundEmployees[request.indexPath].employeeName
        let response = EmployeesList.EmployeeDetails.Response()
        presenter?.presentEmployeeDetail(response: response)
    }
}
