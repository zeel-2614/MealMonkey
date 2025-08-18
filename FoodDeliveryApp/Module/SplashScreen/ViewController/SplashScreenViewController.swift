import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the splash screen (though navigation bar is hidden)
        self.title = "Splash Screen"
        // Hide navigation bar when splash screen loads
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Ensure navigation bar stays hidden when the splash screen appears
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Simulate a splash screen delay of 3 seconds
        sleep(3)
        
        // Load the "UserStoryboard"
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        
        // Instantiate LoginViewController and navigate to it
        if let VC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

