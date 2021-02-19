//
//  ReachabilitySpy.swift
//  BankUnited_Tests
//
//

import BasicCommons

class ReachabilitySpy: ReachabilityCheckingProtocol {

    var isConnectedToNetworkCalled = false

    var isConnectedToNetworkReturnValue = true

    func isConnectedToNetwork() -> Bool {
        isConnectedToNetworkCalled = true
        return isConnectedToNetworkReturnValue
    }
}
