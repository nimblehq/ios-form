//
//  FormDataSource.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

import Foundation

protocol FormDataSourceDelegate: AnyObject {

    func dataSourceDidChangeSections(_ dataSource: FormDataSource)
    func dataSource(_ dataSource: FormDataSource, didUpdateAt indexPath: IndexPath)
}

final class FormDataSource {

    private(set) var sections: [FormSection] = [] {
        didSet {
            delegate?.dataSourceDidChangeSections(self)
        }
    }

    var fields: [FormField] {
        Array(sections.compactMap { $0.fields }.joined())
    }

    weak var delegate: FormDataSourceDelegate?

    func updateSections(_ sections: [FormSection]) {
        self.sections = sections
    }

    func updateValue<Field: FieldDataSource>(for formField: Field.Type, with value: Field.Value, byKey key: String) {
        guard
            let indexPath = indexPath(of: key),
            let field = sections[indexPath.section].fields[indexPath.row] as? Field
        else { return }
        field.value = value
        if let field = field as? FormField {
            sections[indexPath.section].fields[indexPath.row] = field
            reloadField(by: key)
        }
    }

    func getValue<Field: FieldDataSource>(of formField: Field.Type, byKey key: String) -> Field.Value? {
        let field = fields.first(where: { $0.key == key }) as? Field
        return field?.value
    }

    func updateDataSource<Field: InputDataSource>(for formField: Field.Type, with dataSource: [Field.Item], byKey key: String) {
        guard
            let indexPath = indexPath(of: key),
            let field = sections[indexPath.section].fields[indexPath.row] as? Field
        else { return }
        field.dataSource = dataSource
        if let field = field as? FormField {
            sections[indexPath.section].fields[indexPath.row] = field
        }
    }

    private func reloadField(by key: String) {
        guard let indexPath = indexPath(of: key) else { return }
        delegate?.dataSource(self, didUpdateAt: indexPath)
    }

    private func indexPath(of key: String) -> IndexPath? {
        var indexPath: IndexPath?
        for (index, section) in sections.enumerated() {
            if let firstIndex = section.fields.firstIndex(where: { $0.key == key }) {
                indexPath = IndexPath(row: firstIndex, section: index)
                break
            }
        }
        return indexPath
    }
}
