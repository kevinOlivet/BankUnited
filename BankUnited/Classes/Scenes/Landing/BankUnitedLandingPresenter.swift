//
//  BankUnitedLandingPresenter.swift
//  Pods
//
//  Copyright Jon Kevin Olivet
//

import UIKit

protocol BankUnitedLandingPresentationLogic {
    func presentSetupUI(response: BankUnitedLanding.Basic.Response)
}

class BankUnitedLandingPresenter: BankUnitedLandingPresentationLogic {
    weak  var viewController: BankUnitedLandingDisplayLogic?

    // MARK: Methods

    func presentSetupUI(response: BankUnitedLanding.Basic.Response) {
        let viewModel = BankUnitedLanding.Basic.ViewModel(
            title: response.title.localized,
            subtitle: response.subtitle.localized
        )
        viewController?.displaySetupUI(viewModel: viewModel)
    }
}
