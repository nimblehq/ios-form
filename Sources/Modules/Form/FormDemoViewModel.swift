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
          TextInputFormField(key: FormKey.username.rawValue, viewModel: .init(title: "Username", value: nil, isSecure: false)),
          TextInputFormField(key: FormKey.password.rawValue, viewModel: .init(title: "Password", value: nil, isSecure: true))
        ]
      ),
      .init(fields: [
        TextInputFormField(key: FormKey.fullName.rawValue, viewModel: .init(title: "Full Name", value: "Admin", isSecure: false))
      ])
    ]
    view?.dataSource.updateSections(sections)
  }

  func didTapSaveButton() {
    getValueFromForm()
    updateValueForForm()
  }

  private func getValueFromForm() {
    if let viewModel = view?.dataSource.getViewModel(from: TextInputFormField.self, byKey: FormKey.username.rawValue) {
      print(viewModel.value ?? "nil")
    }
  }

  private func updateValueForForm() {
    if var viewModel = view?.dataSource.getViewModel(from: TextInputFormField.self, byKey: FormKey.password.rawValue) {
      viewModel.isSecure = !viewModel.isSecure
      view?.dataSource.updateViewModel(for: TextInputFormField.self, with: viewModel, byKey: FormKey.password.rawValue)
    }
  }
}

// MARK: - Form Keys
extension FormDemoViewModel {

  enum FormKey: String {

    case username
    case password
    case fullName
  }
}
