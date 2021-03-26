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
    let sections: [FormSection] = [
      .init(
        header: TitleFormHeader(key: "Profile", viewModel: .init(title: "Profile")),
        fields: [
          TextInputFormField(key: FormKey.username(), viewModel: .init(title: "Username", value: nil, isSecure: false)),
          TextInputFormField(key: FormKey.password(), viewModel: .init(title: "Password", value: nil, isSecure: true))
        ]
      ),
      .init(fields: [
        TextInputFormField(key: FormKey.fullName(), viewModel: .init(title: "Full Name", value: "Admin", isSecure: false))
      ])
    ]
    view?.dataSource.updateSections(sections)
  }

  func didTapSaveButton() {}
}

// MARK: - Form Keys
extension FormDemoViewModel {

  enum FormKey: String {

    case username
    case password
    case fullName

    func callAsFunction() -> String { rawValue }
  }
}
