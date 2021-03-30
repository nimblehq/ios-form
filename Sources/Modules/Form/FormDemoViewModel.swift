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
                    TextInputFormField(key: FormKey.password(), viewModel: .init(title: "Password", isSecure: true)),
                    ToggleInputFormField(key: FormKey.remember(), viewModel: .init(title: "Remember me"))
                ]
            ),
            .init(
                fields: [
                    TextInputFormField(
                        key: FormKey.fullName(),
                        viewModel: .init(title: "Full Name", value: "Admin")
                    ),
                    SelectInputFormField<Country>(
                        key: FormKey.country(),
                        viewModel: .init(title: "Country"),
                        dataSource: Country.list,
                        router: router
                    ),
                    SelectInputFormField<Province>(
                        key: FormKey.province(),
                        viewModel: .init(title: "Province"),
                        router: router
                    )
                ]
            )
        ]
        view?.dataSource.updateSections(sections)
        view?.dataSource.fields.forEach {
            $0.delegate = self
        }
    }

    func didTapSaveButton() {
        guard let view = view else { return }
        var message = ""
        let username = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormKey.username())
        message += "username: \(username)\n"
        let password = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormKey.password())
        message += "password: \(password)\n"
        let rememberMe = view.dataSource.getValue(of: ToggleInputFormField.self, byKey: FormKey.remember())
        message += "rememberMe: \(rememberMe)\n"
        let fullName = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormKey.fullName())
        message += "fullName: \(fullName)\n"
        if let country = view.dataSource.getValue(of: SelectInputFormField<Country>.self, byKey: FormKey.country()) {
            message += "country: \(country.title)\n"
        }
        if let province = view.dataSource.getValue(of: SelectInputFormField<Province>.self, byKey: FormKey.province()) {
            message += "province: \(province.title)\n"
        }
        router.presentAlert(with: message)
    }
}

extension FormDemoViewModel: FormFieldDelegate {

    func fieldDidChangeValue(_ field: FormField) {
        guard let view = view else { return }
        switch field.key {
        case FormKey.country.rawValue:
            guard
                let country = view.dataSource.getValue(of: SelectInputFormField<Country>.self, byKey: FormKey.country())
            else { return }
            if country.title == "Thailand" {
                view.dataSource.updateDataSource(
                    for: SelectInputFormField<Province>.self,
                    with: Province.thaiProvinces,
                    byKey: FormKey.province()
                )
            } else {
                view.dataSource.updateDataSource(
                    for: SelectInputFormField<Province>.self,
                    with: Province.vietProvinces,
                    byKey: FormKey.province()
                )
            }
            view.dataSource.updateValue(
                for: SelectInputFormField<Province>.self,
                with: nil,
                byKey: FormKey.province()
            )
        default: break
        }
    }
}

// MARK: - Form Keys
extension FormDemoViewModel {

    enum FormKey: String {

        case username
        case password
        case remember
        case fullName
        case country
        case province

        func callAsFunction() -> String { rawValue }
    }
}
