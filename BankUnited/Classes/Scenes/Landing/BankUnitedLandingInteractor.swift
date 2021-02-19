//
//  BankUnitedLandingInteractor.swift
//  Pods
//
//  Copyright Jon Kevin Olivet
//

import Foundation

protocol BankUnitedLandingBusinessLogic {
    func setupUI(request: BankUnitedLanding.Basic.Request)
}

protocol BankUnitedLandingDataStore {}

class BankUnitedLandingInteractor: BankUnitedLandingBusinessLogic, BankUnitedLandingDataStore {
    var presenter: BankUnitedLandingPresentationLogic?
    var worker: BankUnitedLandingWorker = BankUnitedLandingWorker()

    // MARK: Methods

    func setupUI(request: BankUnitedLanding.Basic.Request) {
        let response = BankUnitedLanding.Basic.Response(
            title: "WELCOME_TITLE",
            subtitle: "WELCOME_SUBTITLE"
        )
        presenter?.presentSetupUI(response: response)
    }
}
