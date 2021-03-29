//
//  TitleFormHeader.swift
//  iOSForm
//
//  Created by Su Van Ho on 25/03/2021.
//

import UIKit

final class TitleFormHeader {

    let key: String
    let viewModel: TitleHeaderFooterViewModel

    init(key: String, viewModel: TitleHeaderFooterViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

extension TitleFormHeader: FormHeader {

    var height: CGFloat { 60.0 }

    func register(for tableView: UITableView) {
        tableView.register(TitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "TitleHeaderFooterView")
    }

    func dequeue(for tableView: UITableView, in section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitleHeaderFooterView")
        let headerView = view as? TitleHeaderFooterView
        headerView?.configure(with: viewModel)
        return headerView
    }
}
