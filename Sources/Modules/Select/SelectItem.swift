//
//  SelectItem.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

protocol SelectItem: AnyObject, Equatable {

    var title: String { get set }
}

extension SelectItem {

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.title == rhs.title }
}
