//
//  SelectViewModel.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

final class SelectViewModel {

    weak var view: SelectViewInput?
    weak var output: SelectModuleOutput?

    private(set) var list: [String] = []
}

// MARK: - SelectViewOutput

extension SelectViewModel: SelectViewOutput {

    func viewDidLoad() {
        view?.configure()
        view?.setTitle(output?.title)
        list = output?.list ?? []
        view?.reloadTableView()
    }

    func didSelectItem(at index: Int) {
        output?.didSelectItem(at: index)
    }
}
