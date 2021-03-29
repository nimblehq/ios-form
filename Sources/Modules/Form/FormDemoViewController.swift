//
//  FormDemoViewController.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol FormDemoViewInput: FormViewInput {

    var dataSource: FormDataSource { get }

    func configure()
}

protocol FormDemoViewOutput: AnyObject {

    func viewDidLoad()
    func didTapSaveButton()
}

final class FormDemoViewController: FormViewController {

    var output: FormDemoViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - Private

extension FormDemoViewController {

    private func setUpLayout() {}

    private func setUpViews() {
        navigationItem.title = "Form Demo"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(didTapSaveButton)
        )

        tableView.keyboardDismissMode = .onDrag
    }

    @objc private func didTapSaveButton() {
        output?.didTapSaveButton()
    }
}

// MARK: - FormDemoViewInput

extension FormDemoViewController: FormDemoViewInput {

    func configure() {
        setUpLayout()
        setUpViews()
    }
}
