//
//  CreateEmployeeInteractor.swift
//  Pods
//
//

import BasicCommons

protocol CreateEmployeeBusinessLogic {
    func prepareSetUpUI(request: CreateEmployee.Texts.Request)
    func evaluateState(request: CreateEmployee.EvaluateState.Request)
    func sendData(request: CreateEmployee.Base.Request)
}

protocol CreateEmployeeDataStore {}

class CreateEmployeeInteractor: CreateEmployeeBusinessLogic, CreateEmployeeDataStore {
    
    var presenter: CreateEmployeePresentationLogic?
    var worker: CreateEmployeeWorker = CreateEmployeeWorker()

    // Use to populate the request.
    var name: String!
    var salary: String!
    var age: String!
    
    // MARK: Methods
    func prepareSetUpUI(request: CreateEmployee.Texts.Request) {
        let response = CreateEmployee.Texts.Response(
            title: "NEW",
            nameTitle: "NAME",
            salaryTitle: "SALARY",
            ageTitle: "AGE",
            buttonTitle: "SUBMIT"
        )
        presenter?.presentSetupUI(response: response)
    }

    func evaluateState(request: CreateEmployee.EvaluateState.Request) {
        if let safeName = request.name,         // Unwrap the name
           !safeName.trimmedString.isEmpty,     // Make sure it's not just spacees
           let safeSalary = request.salary,     // Unwrap  the salary
           Int(safeSalary) != nil,              // Make sure it's a number
           let safeAge = request.age,           // Unwrap the age
           Int(safeAge) != nil {                // Make sure it's a number
            name = safeName
            salary = safeSalary
            age = safeAge
            let response = CreateEmployee.EvaluateState.Response(activateButton: true)
            presenter?.presentButtonState(response: response)
        } else {
            let response = CreateEmployee.EvaluateState.Response(activateButton: false)
            presenter?.presentButtonState(response: response)
        }
    }
    
    func sendData(request: CreateEmployee.Base.Request) {
        presenter?.presentLoadingView()

        worker.postData(
            name: name,
            salary: salary,
            age: age,
            successCompletion: { [weak self] (receivedData) in
                self?.presenter?.hideLoadingView()
                if let receivedData = receivedData {
                    let response = CreateEmployee.Base.Response(
                        data: receivedData.data,
                        name: receivedData.data.name,
                        salary: receivedData.data.salary,
                        age: receivedData.data.age,
                        id: receivedData.data.id
                    )
                    self?.presenter?.presentData(response: response)
                } else {
                    let response = CreateEmployee.Failure.Response(errorType: .service)
                    self?.presenter?.presentErrorAlert(response: response)
                }

            }) { (error, statusCode) in
            self.presenter?.hideLoadingView()
            if statusCode == ErrorCode.tooManyRequests.rawValue {
                let response = CreateEmployee.Failure.Response(errorType: .tooManyRequests)
                self.presenter?.presentErrorAlert(response: response)
            } else {
                let response = CreateEmployee.Failure.Response(errorType: .internet)
                self.presenter?.presentErrorAlert(response: response)
            }
        }
    }
    
}
