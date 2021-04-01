//
//  FormSection.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

final class FormSection {

    var key: String
    var header: FormHeader?
    var fields: [FormField]

    init(key: String, header: FormHeader? = nil, fields: [FormField]) {
        self.key = key
        self.header = header
        self.fields = fields
    }
}
