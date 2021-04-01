//
//  FormDemoRouter.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

protocol FormDemoRouterInput: AnyObject {

    func show(on window: UIWindow)
}

final class FormDemoRouter {

    weak var view: FormDemoViewInput?

    var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - FormDemoRouterInput

extension FormDemoRouter: FormDemoRouterInput {

    func show(on window: UIWindow) {
        guard let viewController = viewController else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }

    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "iOSForm", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - OpenSelectRouterInput

extension FormDemoRouter: OpenSelectRouterInput {}
