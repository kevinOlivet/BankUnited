//
//  CreateEmployeeWorker.swift
//  BankUnited
//
//

import BasicCommons

class CreateEmployeeWorker {

    var reachability: ReachabilityCheckingProtocol = Reachability()
    var repo: APIBankUnitedProtocol = APIBankUnited()

    func postData(
        name: String,
        salary: String,
        age: String,
        successCompletion: @escaping (CreateEmployeeModel?) -> Void,
        failureCompletion: @escaping (NTError, Int?) -> Void
    ) {
        guard reachability.isConnectedToNetwork() else {
            failureCompletion(NTError.noInternetConection, nil)
            return
        }
        
        repo.postNewEmployee(
            name: name,
            salary: salary,
            age: age,
            success: { receivedData, _ in
                successCompletion(receivedData)
            }) { error, statusCode in
                failureCompletion(error, statusCode)
        }
    }

}
