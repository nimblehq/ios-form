//
//  Province.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

final class Province: SelectItem {

    var title: String

    init(title: String) {
        self.title = title
    }
}

extension Province {

    static let vietProvinces: [Province] = {
        [.init(title: "Hanoi"), .init(title: "Hanoi 1")]
    }()

    static let thaiProvinces: [Province] = {
        [.init(title: "Bangkok"), .init(title: "Bangkok 1")]
    }()
}
