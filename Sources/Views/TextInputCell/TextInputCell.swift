//
//  TextInputCell.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol TextInputCellDelegate: AnyObject {
    
    func cell(_ cell: TextInputCell, didChangeValue value: String?)
}

final class TextInputCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    weak var delegate: TextInputCellDelegate?
    
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
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        delegate?.cell(self, didChangeValue: textField.text)
    }
}

// MARK: - Configure

extension TextInputCell {
    
    func configure(_ viewModel: TextInputViewModel) {
        titleLabel.text = viewModel.title
        
        textField.placeholder = viewModel.title
        textField.text = viewModel.value
        textField.isSecureTextEntry = viewModel.isSecure
        textField.textAlignment = .right
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
}
