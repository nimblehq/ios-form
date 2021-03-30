//
//  FieldDataSource.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

protocol FieldDataSource: AnyObject {

    associatedtype Value
    associatedtype ViewModel

    var viewModel: ViewModel { get set }
    var value: Value { get set }
}
