//
//  EmployeeDetailRouter.swift
//  BankUnited
//
//

import UIKit

@objc
protocol EmployeeDetailRoutingLogic {
    func closeToDashboard()
    func routeToBack()
}

protocol EmployeeDetailDataPassing {
    var dataStore: EmployeeDetailDataStore? { get }
}

class EmployeeDetailRouter: NSObject, EmployeeDetailRoutingLogic, EmployeeDetailDataPassing {

    weak var viewController: EmployeeDetailViewController?
    var dataStore: EmployeeDetailDataStore?

    // MARK: Routing
    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

}
