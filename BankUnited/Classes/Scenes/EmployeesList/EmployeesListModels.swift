//
//  EmployeesListModels.swift
//  Pods
//
//

// swiftlint:disable nesting
import BasicUIElements

enum EmployeesList {

    enum Texts {
        struct Request {}
        struct Response {
            let title: String
            let buttonTitle: String
        }
        struct ViewModel {
            let title: String
            let buttonTitle: String
        }
    }

    enum Employees {
      struct Request {}
      struct Response {
        let employeesArray: [EmployeesModel.Datum]
      }
      struct ViewModel {
        let displayEmployeesArray: [DisplayEmployeesSuccess]
        struct DisplayEmployeesSuccess {
            let nameTitle: String
            let name: String
            let salaryTitle: String
            let salary: String
            let ageTitle: String
            let age: String
        }
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

    enum EmployeeDetails {
        struct Request {
            let indexPath: Int
        }
        struct Response {}
        struct ViewModel {}

    }
    
}

// swiftlint:enable nesting
