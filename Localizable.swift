import Foundation;
import UIKit;

extension String {
        public var localized: String {
            return NSLocalizedString(self, comment: "")
    }
}

extension UILabel {
    @IBInspectable public var localizedString: String? {
        get { return nil }
        set {
            text = newValue?.localized
        }
    }
}

extension UIButton {
    @IBInspectable public var localizedString: String? {
        get { return nil }
        set {
            setTitle(newValue?.localized, for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable public var localizedString: String? {
        get { return nil }
        set {
            placeholder = newValue?.localized
        }
    }
}


extension UISearchBar {
    @IBInspectable public var localizedString: String? {
        get{ return nil }
        set{
            self.placeholder = newValue?.localized
        }
    }
}

extension UITextView{
    
    @IBInspectable public var localizedString: String? {
        get{ return nil }
        set{
            self.text = newValue?.localized
        }
    }
}

extension UISegmentedControl {
    @IBInspectable public var localizedString: String? {
        get { return nil }
        set {
            guard let keys = newValue?.components(separatedBy: ","), !(newValue?.isEmpty)! else { return }
            for (index, title) in keys.enumerated() {
                setTitle(title.localized, forSegmentAt: index)
            }
        }
    }
}

extension UINavigationItem {
    @IBInspectable public var localizedString: String? {
        get { return nil}
        set {
            self.title = newValue?.localized
        }
    }
}

extension UIBarItem {
    @IBInspectable public var localizedString: String? {
        get { return nil }
        set {
            self.title = newValue?.localized
        }
    }
}


let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"
let LCLDefaultLanguage = "en"
let LCLBaseBundle = "Base"
public let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"

open class Localizable:NSObject {

    open class func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.index(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    open class func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    open class func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
    open class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        //if (selectedLanguage != currentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.set([language], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage(language)
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
       // }
    }
    
    open class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    open class func isCurrentLanguageRTL(language:String) -> Bool {
        return Locale.characterDirection(forLanguage: language) == .rightToLeft
    }
}
