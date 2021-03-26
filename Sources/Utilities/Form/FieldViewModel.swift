//
//  FieldViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

protocol FieldViewModel: AnyObject {

  associatedtype ViewModel

  var viewModel: ViewModel { get set }

}
