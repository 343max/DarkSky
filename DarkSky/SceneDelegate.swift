//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let controller = DarkSkyController(loader: DarkSkyNetworkLoader(apiKey: "ab6d23ede69ee424bd7a4de3e4b7c831"), cacher: DarkSkyDiscCaching())
//            let controller = DarkSkyController(loader: DarkSkyDiskLoader())

            let view = NavigationView(content: {
                LocationListView(locations: Location.DVLocations, controller: controller)
            })
            
            window.rootViewController = UIHostingController(rootView: view)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

