//
//  CreateEmployeeModels.swift
//  Pods
//
//

import BasicUIElements

enum CreateEmployee {
    
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
            let data: CreateEmployeeModel.Datum
            let name: String
            let salary: String
            let age: String
            let id: Int
        }
        struct ViewModel {
            let title: String
            let message: String
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

    enum EvaluateState {
        struct Request {
            let name: String?
            let salary: String?
            let age: String?
        }
        struct Response {
            let activateButton: Bool
        }
        struct ViewModel {
            let activateButton: Bool
        }
    }

    enum CharacterLimit: Int {
        case name = 50
        case salary = 18
        case age = 3
    }
    
}
