//
//  BankUnitedLandingPresentationLogicSpy.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited

class BankUnitedLandingPresentationLogicSpy: BankUnitedLandingPresentationLogic {

    var presentSetupUICalled = false
    var presentSetupUIResponse: BankUnitedLanding.Basic.Response?

    func presentSetupUI(response: BankUnitedLanding.Basic.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
}
