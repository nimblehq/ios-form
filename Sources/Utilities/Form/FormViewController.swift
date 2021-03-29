//
//  FormViewController.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol FormViewInput: AnyObject {

    func reloadTableView(at indexPaths: [IndexPath])
}

class FormViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .grouped)

    let dataSource = FormDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configure

extension FormViewController {

    private func configure() {
        setUpLayout()
        setUpViews()
    }

    private func setUpLayout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setUpViews() {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        dataSource.delegate = self
    }
}

// MARK: - FormDataSourceDelegate

extension FormViewController: FormDataSourceDelegate {

    func dataSourceDidChangeSections(_ dataSource: FormDataSource) {
        for section in dataSource.sections {
            section.header?.register(for: tableView)
            for field in section.fields {
                field.register(for: tableView)
            }
        }
        tableView.reloadData()
    }

    func dataSource(_ dataSource: FormDataSource, didUpdateAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - FormViewInput

extension FormViewController: FormViewInput {

    func reloadTableView(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
}

// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.sections[section].fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = dataSource.sections[indexPath.section].fields[indexPath.row]
        return field.dequeue(for: tableView, at: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let field = dataSource.sections[indexPath.section].fields[indexPath.row]
        return field.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource.sections[section].header?.dequeue(for: tableView, in: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = dataSource.sections[section].header else { return .zero }
        return header.height
    }
}
