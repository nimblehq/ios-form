//
//  SceneDelegate.swift
//  iOSForm
//
//  Created by Su Van Ho on 24/03/2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    let module = FormDemoModule()
    module.router.show(on: window)
    window.makeKeyAndVisible()
    self.window = window
  }
}
