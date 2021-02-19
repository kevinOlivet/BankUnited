//
//  BankUnitedLandingDisplayLogicSpy.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited

class BankUnitedLandingDisplayLogicSpy: BankUnitedLandingDisplayLogic {

    var displaySetupUICalled = false
    var displaySetupUIViewModel: BankUnitedLanding.Basic.ViewModel?

    func displaySetupUI(viewModel: BankUnitedLanding.Basic.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
}
