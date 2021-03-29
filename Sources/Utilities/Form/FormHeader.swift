//
//  FormHeader.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol FormHeader: AnyObject {

    var key: String { get }
    var height: CGFloat { get }

    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, in section: Int) -> UIView?
}
