//
//  TitleHeaderFooterView.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

import UIKit

struct TitleHeaderFooterViewModel {

    let title: String
}

final class TitleHeaderFooterView: UITableViewHeaderFooterView {

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    func configure(with viewModel: TitleHeaderFooterViewModel) {
        titleLabel.text = viewModel.title
    }
}

// MARK: - Private helper

extension TitleHeaderFooterView {

    private func setUpView() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }

        titleLabel.textColor = .systemGray
        titleLabel.font = UIFont.systemFont(ofSize: 12.0)
    }
}
