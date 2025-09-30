import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    
    enum Language: String, CaseIterable {
        case english = "en"
        case hindi = "hi"
        case gujarati = "gu"
        
        var displayName: String {
            switch self {
            case .english: return "English"
            case .hindi: return "हिन्दी"
            case .gujarati: return "ગુજરાતી"
            }
        }
    }

    private let languageKey = "selectedLanguage"
    
    var currentLanguage: Language {
        get {
            if let code = UserDefaults.standard.string(forKey: languageKey),
               let lang = Language(rawValue: code) {
                return lang
            }
            return .english
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: languageKey)
            UserDefaults.standard.synchronize()
            Bundle.setLanguage(newValue.rawValue)
        }
    }
    
    func setLanguage(_ lang: Language) {
        currentLanguage = lang
        reloadAppInterface()
    }
    
    func reloadAppInterface() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = scene.delegate as? SceneDelegate,
              let window = delegate.window else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        window.makeKeyAndVisible()
    }
}
