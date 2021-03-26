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

    static let vietProvinces: [Province] = {
        return [.init(title: "Hanoi"), .init(title: "Hanoi 1")]
    }()

    static let thaiProvinces: [Province] = {
        return [.init(title: "Bangkok"), .init(title: "Bangkok 1")]
    }()
}
