//
//  TextInputViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

struct TextInputViewModel {

    var title: String
    var value: String?
    var isSecure: Bool

    init(title: String, value: String? = nil, isSecure: Bool = false) {
        self.title = title
        self.value = value
        self.isSecure = isSecure
    }
}
