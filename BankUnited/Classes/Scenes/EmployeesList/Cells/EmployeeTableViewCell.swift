//
//  EmployeeTableViewCell.swift
//  BankUnited
//
//

import BasicUIElements

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameDisplayLabel: UILabel!
    @IBOutlet private weak var salaryTitleLabel: UILabel!
    @IBOutlet private weak var salaryDisplayLabel: UILabel!
    @IBOutlet private weak var ageTitleLabel: UILabel!
    @IBOutlet private weak var ageDisplayLabel: UILabel!

    var objectVM: EmployeesList.Base.ViewModel.DisplayEmployeesSuccess? {
        didSet {
            nameTitleLabel.text = objectVM?.nameTitle
            nameDisplayLabel.text = objectVM?.name
            salaryTitleLabel.text = objectVM?.salaryTitle
            salaryDisplayLabel.text = objectVM?.salary
            ageTitleLabel.text = objectVM?.ageTitle
            ageDisplayLabel.text = objectVM?.age
        }
    }

    // Getters
    var nameTitleLabelText: String? { nameTitleLabel.text }
    var nameDisplayLabelText: String? { nameDisplayLabel.text }
    var salaryTitleLabelText: String? { salaryTitleLabel.text }
    var salaryDisplayLabelText: String? { salaryDisplayLabel.text }
    var ageTitleLabelText: String? { ageTitleLabel.text }
    var ageDisplayLabelText: String? { ageDisplayLabel.text }
}
