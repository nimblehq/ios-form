//
//  DateInputCell.swift
//  iOSForm
//
//  Created by Su Van Ho on 01/04/2021.
//

import UIKit

protocol DateInputCellDelegate: AnyObject {

    func cell(_ cell: DateInputCell, didChangeValue value: Date)
}

final class DateInputCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0.0, y: 0.0, width: 100.0, height: 100.0))

    weak var delegate: DateInputCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview()
        }

        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date

        textField.textAlignment = .right
        textField.inputView = datePicker

        configureToolbar()
    }

    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }

    @objc private func didTapDoneButton() {
        delegate?.cell(self, didChangeValue: datePicker.date)
        endEditing(true)
    }
}

// MARK: - Configure

extension DateInputCell {

    func configure(_ viewModel: DateInputViewModel) {
        titleLabel.text = viewModel.title

        textField.placeholder = viewModel.title
        textField.text = viewModel.valueString
    }
}
