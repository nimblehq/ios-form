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
                header: TitleFormHeader(key: "Profile", viewModel: .init(title: "PROFILE")),
                fields: [
                    TextInputFormField(key: FormKey.username(), viewModel: .init(title: "Username")),
                    TextInputFormField(key: FormKey.password(), viewModel: .init(title: "Password", value: nil))
                ]
            ),
            .init(fields: [
                TextInputFormField(key: FormKey.fullName(), viewModel: .init(title: "Full Name", value: "Admin"))
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
