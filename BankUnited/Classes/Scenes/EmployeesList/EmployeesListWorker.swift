//
//  EmployeesListWorker.swift
//  Pods
//
//

import BasicCommons

class EmployeesListWorker {

    var reachability: ReachabilityCheckingProtocol = Reachability()
    var repo: APIBankUnitedProtocol = APIBankUnited()

    func getEmployeesList(
        successCompletion: @escaping (EmployeesModel?) -> Void,
        failureCompletion: @escaping (NTError, Int?) -> Void
    ) {
        guard reachability.isConnectedToNetwork() else {
            failureCompletion(NTError.noInternetConection, nil)
            return
        }
        repo.getEmployees(
            success: { receivedEmployees, _ in
                successCompletion(receivedEmployees)
            }) { error, statusCode in
                failureCompletion(error, statusCode)
            }
    }

}
