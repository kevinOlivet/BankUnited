//
//  EmployeeDetailWorker.swift
//  BankUnited
//
//

import BasicCommons

class EmployeeDetailWorker {

    var reachability: ReachabilityCheckingProtocol = Reachability()
    var repo: APIBankUnitedProtocol = APIBankUnited()

    func getData(
        selectedEmployeeId: String,
        successCompletion: @escaping (EmployeeDetailModel?) -> Void,
        failureCompletion: @escaping (NTError, Int?) -> Void
    ) {
        guard reachability.isConnectedToNetwork() else {
            failureCompletion(NTError.noInternetConection, nil)
            return
        }
        repo.getEmployeeDetails(
            selectedEmployeeId: selectedEmployeeId,
            success: { receivedData, _ in
                successCompletion(receivedData)
            }) { error, statusCode in
                failureCompletion(error, statusCode)
        }
    }

}
