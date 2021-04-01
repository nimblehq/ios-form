//
//  FormDataSource.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

import Foundation

protocol FormDataSourceDelegate: AnyObject {

    func dataSourceDidChangeSections(_ dataSource: FormDataSource)
    func dataSourceDidReloadTableView(_ dataSource: FormDataSource)
    func dataSource(_ dataSource: FormDataSource, didUpdateAt indexPaths: [IndexPath])
    func dataSource(_ dataSource: FormDataSource, didInsertAt indexPaths: [IndexPath])
    func dataSource(_ dataSource: FormDataSource, didRemoveAt indexPaths: [IndexPath])
    func dataSource(_ dataSource: FormDataSource, didInsertSectionAt sections: IndexSet)
    func dataSource(_ dataSource: FormDataSource, didRemoveSectionAt sections: IndexSet)
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
        delegate?.dataSourceDidReloadTableView(self)
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

    func getValue<Field: FieldDataSource>(of formField: Field.Type, byKey key: String) -> Field.Value {
        guard let field = fields.first(where: { $0.key == key }) as? Field else {
            fatalError("\(formField) not found with key: \(key)")
        }
        return field.value
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

    func fields(ofSection key: String) -> [FormField] {
        guard let section = sections.first(where: { $0.key == key }) else { return [] }
        return section.fields
    }

    func insertField(_ field: FormField, at index: Int, ofSection key: String) {
        guard let section = sections.firstIndex(where: { $0.key == key }) else { return }
        sections[section].fields.insert(field, at: index)
        let indexPath = IndexPath(row: index, section: section)
        delegate?.dataSource(self, didInsertAt: [indexPath])
    }

    func removeField(_ key: String) {
        guard let indexPath = self.indexPath(of: key) else { return }
        sections[indexPath.section].fields.remove(at: indexPath.row)
        delegate?.dataSource(self, didRemoveAt: [indexPath])
    }

    func insertSection(_ section: FormSection, at index: Int) {
        sections.insert(section, at: index)
        delegate?.dataSource(self, didInsertSectionAt: IndexSet(integer: index))
    }

    func removeSection(withKey key: String) {
        if let index = sections.firstIndex(where: { $0.key == key }) {
            sections.remove(at: index)
            delegate?.dataSource(self, didRemoveSectionAt: .init(integer: index))
        }
    }

    private func reloadField(by key: String) {
        guard let indexPath = indexPath(of: key) else { return }
        delegate?.dataSource(self, didUpdateAt: [indexPath])
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
