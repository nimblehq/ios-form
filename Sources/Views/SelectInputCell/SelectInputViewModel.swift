//
//  SelectInputViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

struct SelectInputViewModel {

    var title: String
    var value: String?

    init(title: String, value: String? = nil) {
        self.title = title
        self.value = value
    }
}
