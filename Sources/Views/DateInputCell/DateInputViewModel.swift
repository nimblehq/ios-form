//
//  DateInputViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 01/04/2021.
//

import Foundation

struct DateInputViewModel {

    let title: String
    var value: Date?
    var valueString: String? {
        value?.string(with: .date)
    }

    init(title: String, value: Date? = nil) {
        self.title = title
        self.value = value
    }
}

extension DateFormatter {

    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

extension Date {

    func string(with formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}
