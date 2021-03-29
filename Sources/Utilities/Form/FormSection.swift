//
//  FormSection.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

final class FormSection {

    var header: FormHeader?
    var fields: [FormField]

    init(header: FormHeader? = nil, fields: [FormField]) {
        self.header = header
        self.fields = fields
    }
}
