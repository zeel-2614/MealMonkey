import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Called after the view is added to the app’s view hierarchy
        
        // Pause the splash screen for 2 seconds
        // Note: Using sleep blocks the main thread and freezes the UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            if UserDefaults.standard.bool(forKey: Main.Key.isLoggedInKey) {
                self.showMainTabBar()
            } else {
                let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
                if let loginVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) as? LoginViewController {
                    let navController = UINavigationController(rootViewController: loginVC)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = navController
                        sceneDelegate.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.Storyboards.homeStoryBoard, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.mainTabBarViewController) as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
}
