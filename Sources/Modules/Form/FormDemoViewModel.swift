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
                    TextInputFormField(key: FormKey.password(), viewModel: .init(title: "Password", isSecure: true))
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
        view?.dataSource
            .updateValue(
                for: SelectInputFormField<Country>.self,
                with: Country(title: "Vietnam"),
                byKey: FormKey.country()
            )
    }
}

extension FormDemoViewModel: FormFieldDelegate {

    func fieldDidChangeValue(_ field: FormField) {
        switch field.key {
        case FormKey.country.rawValue:
            guard
                let value = view?.dataSource.getValue(of: SelectInputFormField<Country>.self, byKey: FormKey.country()),
                let country = value
            else { return }
            if country.title == "Thailand" {
                view?.dataSource.updateDataSource(
                    for: SelectInputFormField<Province>.self,
                    with: Province.thaiProvinces,
                    byKey: FormKey.province()
                )
            } else {
                view?.dataSource.updateDataSource(
                    for: SelectInputFormField<Province>.self,
                    with: Province.vietProvinces,
                    byKey: FormKey.province()
                )
            }
            view?.dataSource.updateValue(
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
        case fullName
        case country
        case province

        func callAsFunction() -> String { rawValue }
    }
}
