//
//  InputDataSource.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

protocol InputDataSource: AnyObject {

    associatedtype Item

    var dataSource: [Item] { get set }
}
