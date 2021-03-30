//
//  ToggleInputFormField.swift
//  iOSForm
//
//  Created by Su Van Ho on 30/03/2021.
//

import UIKit

final class ToggleInputFormField {

    let key: String
    var viewModel: ToggleInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: ToggleInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

// MARK: - FormField

extension ToggleInputFormField: FormField {

    var height: CGFloat { 44.0 }

    func register(for tableView: UITableView) {
        tableView.register(ToggleInputCell.self, forCellReuseIdentifier: "ToggleInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleInputCell", for: indexPath) as! ToggleInputCell
        cell.configure(viewModel)
        cell.delegate = self
        return cell
    }
}

// MARK: - FieldDataSource

extension ToggleInputFormField: FieldDataSource {

    var value: Bool {
        get {
            viewModel.value
        }
        set {
            viewModel.value = newValue
        }
    }
}

// MARK: - ToggleInputCellDelegate

extension ToggleInputFormField: ToggleInputCellDelegate {

    func cell(_ cell: ToggleInputCell, didChangeValue value: Bool) {
        viewModel.value = value
    }
}
