//
//  Country.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

final class Country: SelectItem {

    var title: String

    init(title: String) {
        self.title = title
    }
}

extension Country {

    static let list: [Country] = {
        [.init(title: "Vietnam"), .init(title: "Thailand")]
    }()
}
