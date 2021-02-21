//
//  EmployeeDetailModels.swift
//  BankUnited
//
//

import BasicUIElements

enum EmployeeDetail {

    enum Texts {
        struct Request {}
        struct Response {
            let title: String
            let nameTitle: String
            let salaryTitle: String
            let ageTitle: String
            let buttonTitle: String
        }
        struct ViewModel {
            let title: String
            let nameTitle: String
            let salaryTitle: String
            let ageTitle: String
            let buttonTitle: String
        }
    }

    enum Base {
      struct Request {}
      struct Response {
        let data: EmployeeDetailModel.Datum
      }
      struct ViewModel {
        let name: String
        let salary: String
        let age: String
      }
    }

    enum Failure {
      struct Request {}
      struct Response {
        let errorType: FullScreenErrorType
      }
      struct ViewModel {
        let errorType: FullScreenErrorType
      }
    }

}
