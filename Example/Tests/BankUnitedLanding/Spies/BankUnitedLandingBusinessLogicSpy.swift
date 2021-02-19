//
//  BankUnitedLandingBusinessLogicSpy.swift
//  BankUnited
//
//  Copyright Jon Kevin Olivet
//

@testable import BankUnited

class BankUnitedLandingBusinessLogicSpy: BankUnitedLandingBusinessLogic {

    var setupUICalled = false
    var setupUIRequest: BankUnitedLanding.Basic.Request?

    func setupUI(request: BankUnitedLanding.Basic.Request) {
        setupUICalled = true
        setupUIRequest = request
    }
}
