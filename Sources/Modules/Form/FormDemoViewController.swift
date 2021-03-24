//
//  FormDemoViewController.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol FormDemoViewInput: AnyObject {

  func configure()
}

protocol FormDemoViewOutput: AnyObject {

  func viewDidLoad()
}

final class FormDemoViewController: FormViewController {

  var output: FormDemoViewOutput?

  override func viewDidLoad() {
    super.viewDidLoad()
    output?.viewDidLoad()
  }
}

// MARK: - FormDemoViewInput
extension FormDemoViewController: FormDemoViewInput {

  func configure() {
    view.backgroundColor = .white
  }
}
