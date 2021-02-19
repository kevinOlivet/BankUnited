//
//  BankUnitedFactory.swift
//  BankUnited
//
//  Copyright © Jon Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements

/// Class for the BankUnitedFactory
public class BankUnitedFactory {
    /// Init for the BankUnitedFactory
    public init() { }

    /// Func getRootViewController for the BankUnitedFactory
    public func getRootViewController() -> UIViewController {
        BankUnitedMainNavigationController()
    }

    /// Func getExampleRootViewController for the BankUnitedFactory
    public func getExampleRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [BankUnitedMainNavigationController()]
        tabBarController.tabBar.isTranslucent = false
        return tabBarController
    }
}

private class BankUnitedMainNavigationController: UINavigationController {

    let viewController = BankUnitedLandingViewController()

    init() {
        viewController.tabBarItem = UITabBarItem(
            title: "Employees",
            image: MainAsset.tabHome.image,
            tag: 0
        )
        let bundleToUse = Utils.bundle(forClass: BankUnitedLandingViewController.classForCoder())
        super.init(nibName: "BankUnitedLandingViewController", bundle: bundleToUse)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        navigationBar.isHidden = true
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewControllers = [viewController]
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
}
