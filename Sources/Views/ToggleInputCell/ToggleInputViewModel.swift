//
//  ToggleInputViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 30/03/2021.
//

struct ToggleInputViewModel {

    var title: String
    var value: Bool

    init(title: String, value: Bool = false) {
        self.title = title
        self.value = value
    }
}
