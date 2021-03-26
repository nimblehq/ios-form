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

  private var fields: [FormField] {
    Array(sections.compactMap { $0.fields }.joined())
  }

  weak var delegate: FormDataSourceDelegate?

  func updateSections(_ sections: [FormSection]) {
    self.sections = sections
  }

  func getViewModel<FormField: FieldViewModel>(from formField: FormField.Type, byKey key: String) -> FormField.ViewModel? {
    let field = fields.first(where: { $0.key == key }) as? FormField
    return field?.viewModel
  }

  func updateViewModel<Field: FieldViewModel>(for formField: Field.Type, with viewModel: Field.ViewModel, byKey key: String) {
    var indexPath: IndexPath?
    for (i, section) in sections.enumerated() {
      if let j = section.fields.firstIndex(where: { $0.key == key }) {
        indexPath = IndexPath(row: j, section: i)
      }
    }
    guard
      let ip = indexPath,
      let field = sections[ip.section].fields[ip.row] as? Field
    else { return }
    field.viewModel = viewModel
    if let field = field as? FormField {
      sections[ip.section].fields[ip.row] = field
      delegate?.dataSource(self, didUpdateAt: ip)
    }
  }
}
