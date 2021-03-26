//
//  OpenSelectRouterInput.swift
//  iOSForm
//
//  Created by Su Van Ho on 26/03/2021.
//

import UIKit

protocol OpenSelectRouterInput: AnyObject {
    
    var viewController: UIViewController? { get }
    
    func showSelectScreen(output: SelectModuleOutput?)
}

extension OpenSelectRouterInput {
    
    func showSelectScreen(output: SelectModuleOutput?) {
        let module = SelectModule()
        module.output = output
        viewController?.navigationController?.pushViewController(module.view, animated: true)
    }
}

