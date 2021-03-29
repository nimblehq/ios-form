//
//  TextInputFormField.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

final class TextInputFormField {

    let key: String
    var viewModel: TextInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: TextInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

// MARK: - FormField

extension TextInputFormField: FormField {

    var height: CGFloat { 44.0 }

    func register(for tableView: UITableView) {
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
        cell.delegate = self
        cell.configure(viewModel)
        return cell
    }
}

// MARK: - FieldDataSource

extension TextInputFormField: FieldDataSource {

    var value: String? {
        get {
            viewModel.value
        }
        set {
            viewModel.value = newValue
        }
    }
}

// MARK: - TextInputCellDelegate

extension TextInputFormField: TextInputCellDelegate {

    func cell(_ cell: TextInputCell, didChangeValue value: String?) {
        viewModel.value = value
    }
}
