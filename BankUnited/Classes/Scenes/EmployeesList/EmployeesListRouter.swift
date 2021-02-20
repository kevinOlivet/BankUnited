//
//  EmployeesListRouter.swift
//  Pods
//
//

import BasicCommons

@objc
protocol EmployeesListRoutingLogic {
    func closeToDashboard()
    func routeToEmployeeDetail()
    func routeToCreateNewEmployee()
}

protocol EmployeesListDataPassing {
    var dataStore: EmployeesListDataStore? { get }
}

class EmployeesListRouter: NSObject, EmployeesListRoutingLogic, EmployeesListDataPassing {
    weak var viewController: EmployeesListViewController?
    var dataStore: EmployeesListDataStore?

    // MARK: Routing

    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    
    func routeToEmployeeDetail() {
        print("Here: routeToEmployeeDetail")
//        let storyboard = UIStoryboard(
//            name: "EmployeesMain",
//            bundle: Utils.bundle(forClass: EmployeesListViewController.classForCoder())
//        )
//        let destinationNVC = storyboard.instantiateInitialViewController() as! UINavigationController
//        destinationNVC.modalPresentationStyle = .fullScreen
//        navigateToEmployeesList(source: viewController!, destination: destinationNVC)
    }

    // MARK: Navigation
//    func navigateToEmployeesList(source: EmployeesListViewController, destination: UINavigationController) {
//        source.present(destination, animated: true, completion: nil)
//    }

    // MARK: Passing data
//    func passDataToCuotas(source: EmployeesListViewController, destination: inout CuotasCleanDataStore) {
//      destination.amountEntered = source.amountEntered
//      destination.selectedPaymentMethod = source.selectedPaymentMethod
//      destination.bankSelected = source.selectedBankSelect
//    }

    func routeToCreateNewEmployee() {
        print("Here: routeToCreateNewEmployee")
    }
}
