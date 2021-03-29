//
//  FormDemoModule.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

final class FormDemoModule {

    let view: FormDemoViewController
    let viewModel: FormDemoViewModel
    let router: FormDemoRouter

    init() {
        view = FormDemoViewController()
        router = FormDemoRouter()
        viewModel = FormDemoViewModel(router: router)

        view.output = viewModel
        viewModel.view = view
        router.view = view
    }
}
