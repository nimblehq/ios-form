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

    static let list: [Country] = {
        return [.init(title: "Vietnam"), .init(title: "Thailand")]
    }()
}
