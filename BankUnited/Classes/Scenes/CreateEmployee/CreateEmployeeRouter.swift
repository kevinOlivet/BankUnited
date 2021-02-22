//
//  CreateEmployeeRouter.swift
//  Pods
//
//

import BasicCommons

@objc
protocol CreateEmployeeRoutingLogic {
    func closeToDashboard()
    func routeToBack()
}

protocol CreateEmployeeDataPassing {
    var dataStore: CreateEmployeeDataStore? { get }
}

class CreateEmployeeRouter: NSObject, CreateEmployeeRoutingLogic, CreateEmployeeDataPassing {

    weak var viewController: CreateEmployeeViewController?
    var dataStore: CreateEmployeeDataStore?

    // MARK: - Routing
    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
