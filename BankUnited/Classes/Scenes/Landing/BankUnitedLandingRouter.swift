//
//  BankUnitedLandingRouter.swift
//  Pods
//
//  Copyright Jon Kevin Olivet
//

import BasicCommons

@objc
protocol BankUnitedLandingRoutingLogic {
    func routeToEmployeesList()
}

protocol BankUnitedLandingDataPassing {
    var dataStore: BankUnitedLandingDataStore? { get }
}

class BankUnitedLandingRouter: NSObject, BankUnitedLandingRoutingLogic, BankUnitedLandingDataPassing {
    weak var viewController: BankUnitedLandingViewController?
    var dataStore: BankUnitedLandingDataStore?

    // MARK: Routing

    func routeToEmployeesList() {
        let storyboard = UIStoryboard(
            name: "EmployeesMain",
            bundle: Utils.bundle(forClass: EmployeesListViewController.classForCoder())
        )
        let destinationNVC = storyboard.instantiateInitialViewController() as! UINavigationController
        destinationNVC.modalPresentationStyle = .fullScreen
        navigateToEmployeesList(source: viewController!, destination: destinationNVC)
    }

    // MARK: Navigation
    func navigateToEmployeesList(source: BankUnitedLandingViewController, destination: UINavigationController) {
        source.present(destination, animated: true, completion: nil)
    }
}
