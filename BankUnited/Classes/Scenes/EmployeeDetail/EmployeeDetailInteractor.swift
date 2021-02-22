//
//  EmployeeDetailInteractor.swift
//  BankUnited
//
//

import BasicCommons

protocol EmployeeDetailBusinessLogic {
    func prepareSetUpUI(request: EmployeeDetail.Texts.Request)
    func fetchData(request: EmployeeDetail.Base.Request)
}

protocol EmployeeDetailDataStore {
    var selectedItemId: String! { get set }
    var selectedName: String! { get set }
}

class EmployeeDetailInteractor: EmployeeDetailBusinessLogic, EmployeeDetailDataStore {

    var presenter: EmployeeDetailPresentationLogic?
    var worker: EmployeeDetailWorker = EmployeeDetailWorker()
    var selectedItemId: String!
    var selectedName: String!

    // MARK: Methods

    func prepareSetUpUI(request: EmployeeDetail.Texts.Request) {
        let response = EmployeeDetail.Texts.Response(
            title: selectedName,
            nameTitle: "NAME",
            salaryTitle: "SALARY",
            ageTitle: "AGE", 
            buttonTitle: "GO_BACK"
        )
        presenter?.presentSetupUI(response: response)
    }

    func fetchData(request: EmployeeDetail.Base.Request) {
        presenter?.presentLoadingView()

        worker.getData(
            selectedEmployeeId: String(selectedItemId),
            successCompletion: { [weak self] (receivedData) in
                self?.presenter?.hideLoadingView()
                if let receivedData = receivedData {
                    let response = EmployeeDetail.Base.Response(data: receivedData.data)
                    self?.presenter?.presentData(response: response)
                } else {
                    let response = EmployeeDetail.Failure.Response(errorType: .service)
                    self?.presenter?.presentErrorAlert(response: response)
                }
            }) { (error, statusCode) in
            self.presenter?.hideLoadingView()
            if statusCode == ErrorCode.tooManyRequests.rawValue {
                let response = EmployeeDetail.Failure.Response(errorType: .tooManyRequests)
                self.presenter?.presentErrorAlert(response: response)
            } else {
                let response = EmployeeDetail.Failure.Response(errorType: .internet)
                self.presenter?.presentErrorAlert(response: response)
            }
        }
    }

}
