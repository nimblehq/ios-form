//
//  FormDemoViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

final class FormDemoViewModel {

  let router: FormDemoRouter

  weak var view: FormDemoViewInput?

  init(router: FormDemoRouter) {
    self.router = router
  }
}

// MARK: - FormDemoViewOutput

extension FormDemoViewModel: FormDemoViewOutput {

  func viewDidLoad() {
    view?.configure()
  }
}
