//
//  SelectInputFormField.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

import UIKit

final class SelectInputFormField<Value: SelectItem> {

    let key: String
    var viewModel: SelectInputViewModel
    var dataSource: [Value]

    weak var cell: SelectInputCell?
    weak var delegate: FormFieldDelegate?
    weak var router: OpenSelectRouterInput?

    private var selectedIndex: Int?

    init(key: String, viewModel: SelectInputViewModel, dataSource: [Value] = [], router: OpenSelectRouterInput?) {
        self.key = key
        self.viewModel = viewModel
        self.dataSource = dataSource
        self.router = router
    }
}

// MARK: - FormField

extension SelectInputFormField: FormField {

    var height: CGFloat { 44.0 }

    func register(for tableView: UITableView) {
        tableView.register(SelectInputCell.self, forCellReuseIdentifier: "SelectInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectInputCell", for: indexPath) as! SelectInputCell
        cell.configure(viewModel)
        self.cell = cell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataSource.isEmpty { return }
        router?.showSelectScreen(output: self)
    }
}

// MARK: - FieldDataSource

extension SelectInputFormField: FieldDataSource {

    var value: Value? {
        get {
            guard let selectedIndex = selectedIndex else { return nil }
            return dataSource[selectedIndex]
        }
        set {
            if let value = newValue {
                let index = dataSource.firstIndex(of: value)
                selectedIndex = index
                viewModel.value = value.title
            } else {
                selectedIndex = nil
                viewModel.value = nil
            }
            delegate?.fieldDidChangeValue(self)
        }
    }
}

// MARK: - InputDataSource

extension SelectInputFormField: InputDataSource {}

// MARK: - SelectModuleOutput

extension SelectInputFormField: SelectModuleOutput {

    var title: String {
        return "Select Item"
    }

    var list: [String] {
        return dataSource.map { $0.title }
    }

    func didSelectItem(at index: Int) {
        value = dataSource[index]
        cell?.configure(viewModel)
    }
}
