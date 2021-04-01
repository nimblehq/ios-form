//
//  DateInputFormField.swift
//  iOSForm
//
//  Created by Su Van Ho on 01/04/2021.
//

import UIKit

final class DateInputFormField {

    let key: String
    var viewModel: DateInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: DateInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

// MARK: - FormField

extension DateInputFormField: FormField {

    var height: CGFloat { 44.0 }

    func register(for tableView: UITableView) {
        tableView.register(DateInputCell.self, forCellReuseIdentifier: "DateInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateInputCell", for: indexPath) as! DateInputCell
        cell.configure(viewModel)
        cell.delegate = self
        return cell
    }
}

// MARK: - FieldDataSource

extension DateInputFormField: FieldDataSource {

    var value: Date? {
        get {
            viewModel.value
        }
        set {
            viewModel.value = newValue
        }
    }
}

// MARK: - ToggleInputCellDelegate

extension DateInputFormField: DateInputCellDelegate {

    func cell(_ cell: DateInputCell, didChangeValue value: Date) {
        viewModel.value = value
        cell.configure(viewModel)
    }
}
