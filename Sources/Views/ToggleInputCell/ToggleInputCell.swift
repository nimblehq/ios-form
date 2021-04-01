//
//  ToggleInputCell.swift
//  iOSForm
//
//  Created by Su Van Ho on 30/03/2021.
//

import UIKit

protocol ToggleInputCellDelegate: AnyObject {

    func cell(_ cell: ToggleInputCell, didChangeValue value: Bool)
}

final class ToggleInputCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueSwitch = UISwitch()

    weak var delegate: ToggleInputCellDelegate?

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
        contentView.addSubview(valueSwitch)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }

        valueSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }

        valueSwitch.addTarget(self, action: #selector(valueSwitchDidChange), for: .valueChanged)
    }

    @objc private func valueSwitchDidChange() {
        delegate?.cell(self, didChangeValue: valueSwitch.isOn)
    }
}

// MARK: - Configure

extension ToggleInputCell {

    func configure(_ viewModel: ToggleInputViewModel) {
        titleLabel.text = viewModel.title
        valueSwitch.isOn = viewModel.value
    }
}
