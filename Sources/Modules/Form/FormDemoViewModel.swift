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

    private func configureProvinceAfterSelectCountry() {
        guard let view = view else { return }
        guard
            let country = view.dataSource.getValue(
                of: SelectInputFormField<Country>.self,
                byKey: FormFieldKey.country()
            )
        else { return }
        if country.title == "Thailand" {
            view.dataSource.updateDataSource(
                for: SelectInputFormField<Province>.self,
                with: Province.thaiProvinces,
                byKey: FormFieldKey.province()
            )
        } else {
            view.dataSource.updateDataSource(
                for: SelectInputFormField<Province>.self,
                with: Province.vietProvinces,
                byKey: FormFieldKey.province()
            )
        }
        view.dataSource.updateValue(
            for: SelectInputFormField<Province>.self,
            with: nil,
            byKey: FormFieldKey.province()
        )
    }

    private func handleEnabled2FA() {
        guard let view = view else { return }
        let enabled2FA = view.dataSource.getValue(
            of: ToggleInputFormField.self,
            byKey: FormFieldKey.enabled2FA()
        )
        if enabled2FA {
            if !view.dataSource.fields.contains(where: { $0.key == FormFieldKey.twoFA() }) {
                let fields = view.dataSource.fields(ofSection: FormSectionKey.profile())
                view.dataSource.insertField(
                    TextInputFormField(key: FormFieldKey.twoFA(), viewModel: .init(title: "2FA Code")),
                    at: fields.count,
                    ofSection: FormSectionKey.profile()
                )
            }
        } else {
            if view.dataSource.fields.contains(where: { $0.key == FormFieldKey.twoFA() }) {
                view.dataSource.removeField(FormFieldKey.twoFA())
            }
        }
    }

    private func handleEnabledAddress() {
        guard let view = view else { return }
        let enabledAddress = view.dataSource.getValue(
            of: ToggleInputFormField.self,
            byKey: FormFieldKey.enabledAddress()
        )
        if enabledAddress {
            let addressSection = FormSection(
                key: FormSectionKey.address(),
                fields: [
                    SelectInputFormField<Country>(
                        key: FormFieldKey.country(),
                        viewModel: .init(title: "Country"),
                        dataSource: Country.list,
                        router: router
                    ),
                    SelectInputFormField<Province>(
                        key: FormFieldKey.province(),
                        viewModel: .init(title: "Province"),
                        router: router
                    )
                ]
            )
            addressSection.fields.forEach {
                $0.delegate = self
            }
            view.dataSource.insertSection(addressSection, at: view.dataSource.sections.count)
        } else {
            view.dataSource.removeSection(withKey: FormSectionKey.address())
        }
    }
}

// MARK: - FormDemoViewOutput

extension FormDemoViewModel: FormDemoViewOutput {

    func viewDidLoad() {
        view?.configure()
        let sections: [FormSection] = [
            .init(
                key: FormSectionKey.profile(),
                header: TitleFormHeader(key: "Profile", viewModel: .init(title: "PROFILE")),
                fields: [
                    TextInputFormField(
                        key: FormFieldKey.fullName(),
                        viewModel: .init(title: "Full Name", value: "Admin")
                    ),
                    TextInputFormField(key: FormFieldKey.username(), viewModel: .init(title: "Username")),
                    TextInputFormField(
                        key: FormFieldKey.password(),
                        viewModel: .init(title: "Password", isSecure: true)
                    ),
                    ToggleInputFormField(key: FormFieldKey.enabled2FA(), viewModel: .init(title: "Enabled 2FA"))
                ]
            ),
            .init(
                key: FormSectionKey.enabledAddress(),
                fields: [
                    ToggleInputFormField(key: FormFieldKey.enabledAddress(), viewModel: .init(title: "Enabled Address"))
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
        let fullName = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormFieldKey.fullName())
        message += "fullName: \(fullName)\n"
        let username = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormFieldKey.username())
        message += "username: \(username)\n"
        let password = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormFieldKey.password())
        message += "password: \(password)\n"
        let enabled2FA = view.dataSource.getValue(of: ToggleInputFormField.self, byKey: FormFieldKey.enabled2FA())
        message += "enabled2FA: \(enabled2FA)\n"
        if enabled2FA {
            let twoFA = view.dataSource.getValue(of: TextInputFormField.self, byKey: FormFieldKey.twoFA())
            message += "2FA: \(twoFA)\n"
        }
        let enabledAddress = view.dataSource.getValue(
            of: ToggleInputFormField.self,
            byKey: FormFieldKey.enabledAddress()
        )
        message += "enabledAddress: \(enabledAddress)\n"
        if enabledAddress {
            if let country = view.dataSource.getValue(
                of: SelectInputFormField<Country>.self,
                byKey: FormFieldKey.country()
            ) {
                message += "country: \(country.title)\n"
            }
            if let province = view.dataSource.getValue(
                of: SelectInputFormField<Province>.self,
                byKey: FormFieldKey.province()
            ) {
                message += "province: \(province.title)\n"
            }
        }
        router.presentAlert(with: message)
    }
}

extension FormDemoViewModel: FormFieldDelegate {

    func fieldDidChangeValue(_ field: FormField) {
        guard let view = view else { return }
        switch field.key {
        case FormFieldKey.country.rawValue:
            configureProvinceAfterSelectCountry()
        case FormFieldKey.enabled2FA.rawValue:
            handleEnabled2FA()
        case FormFieldKey.enabledAddress.rawValue:
            handleEnabledAddress()
        default: break
        }
    }
}

// MARK: - Form Keys

extension FormDemoViewModel {

    enum FormSectionKey: String {

        case profile
        case enabledAddress
        case address

        func callAsFunction() -> String { rawValue }
    }

    enum FormFieldKey: String {

        case fullName
        case username
        case password
        case enabled2FA
        case twoFA
        case enabledAddress
        case country
        case province

        func callAsFunction() -> String { rawValue }
    }
}
