//
//  SelectInputCell.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

import UIKit

final class SelectInputCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

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
        contentView.addSubview(valueLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }

        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview()
        }

        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)

        valueLabel.textAlignment = .right

        accessoryType = .disclosureIndicator
    }
}

// MARK: - Configure

extension SelectInputCell {

    func configure(_ viewModel: SelectInputViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
