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

    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    // MARK: Routing to Detail
    func routeToEmployeeDetail() {
        let storyboard = UIStoryboard(
            name: "EmployeesMain",
            bundle: Utils.bundle(forClass: EmployeeDetailViewController.classForCoder())
        )
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController
        var destinationDS = destinationVC.router!.dataStore!

        passDataToEmployeeDetail(source: dataStore!, destination: &destinationDS)
        navigateToEmployeeDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation to Detail
    func navigateToEmployeeDetail(source: EmployeesListViewController, destination: EmployeeDetailViewController) {
      viewController?.navigationController?.show(destination, sender: nil)
    }

    // MARK: Passing data to Detail
    func passDataToEmployeeDetail(source: EmployeesListDataStore, destination: inout EmployeeDetailDataStore) {
      destination.selectedItemId = source.selectedEmployeeId
      destination.selectedName = source.selectedEmployeeName
    }

    // MARK: Routing to CreateEmployee
    func routeToCreateNewEmployee() {
//        let storyboard = UIStoryboard(
//            name: "EmployeesMain",
//            bundle: Utils.bundle(forClass: CreateEmployeeViewController.classForCoder())
//        )
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "CreateEmployeeViewController") as! CreateEmployeeViewController
//        var destinationDS = destinationVC.router!.dataStore!
//
//        passDataToCreateEmployee(source: dataStore!, destination: &destinationDS)
//        navigateToCreateEmployee(source: viewController!, destination: destinationVC)
    }
//    // MARK: Navigation to CreateEmployee
//    func navigateToCreateEmployee(source: EmployeesListViewController, destination: CreateEmployeeViewController) {
//      viewController?.navigationController?.show(destination, sender: nil)
//    }
//    // MARK: Passing data to CreateEmployee
//    func passDataToCreateEmployee(source: EmployeesListDataStore, destination: inout CreateEmployeeDataStore) {}
}
