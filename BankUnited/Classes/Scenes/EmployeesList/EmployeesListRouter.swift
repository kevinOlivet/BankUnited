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
        let storyboard = UIStoryboard(
            name: "EmployeesMain",
            bundle: Utils.bundle(forClass: EmployeesListViewController.classForCoder())
        )
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController
        var destinationDS = destinationVC.router!.dataStore!

        passDataToEmployeeDetail(source: dataStore!, destination: &destinationDS)
        navigateToEmployeeDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
    func navigateToEmployeeDetail(source: EmployeesListViewController, destination: EmployeeDetailViewController) {
      viewController?.navigationController?.show(destination, sender: nil)
    }

    // MARK: Passing data
    func passDataToEmployeeDetail(source: EmployeesListDataStore, destination: inout EmployeeDetailDataStore) {
      destination.selectedItemId = source.selectedEmployeeId
      destination.selectedName = source.selectedEmployeeName
    }

    func routeToCreateNewEmployee() {
        print("routeToCreateNewEmployee")
    }
}
