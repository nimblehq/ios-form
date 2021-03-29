//
//  SelectableItem.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

protocol SelectableItem: AnyObject, Equatable {

    var title: String { get set }
}

extension SelectableItem {

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.title == rhs.title }
}
