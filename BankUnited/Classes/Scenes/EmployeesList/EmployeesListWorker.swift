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
        failureCompletion: @escaping (NTError) -> Void
    ) {
        guard reachability.isConnectedToNetwork() == true else {
            failureCompletion(NTError.noInternetConection)
            return
        }
        repo.getEmployees(
            success: { receivedEmployees, _ in
                successCompletion(receivedEmployees)
            }) { error, _ in
                failureCompletion(error)
            }
    }

}
