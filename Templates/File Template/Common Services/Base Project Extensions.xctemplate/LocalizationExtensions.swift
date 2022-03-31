//
//  Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import SwiftyUserDefaults

extension String {
    
    /// localized string value
    var localized: String {
        if let lang = Defaults.userSelectedLanguageCode {
            if let tableName = Bundle.main.infoDictionary?["BRAND_PREFIX"] as? String,
               let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
               let bundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: "")
            }
        }
        return NSLocalizedString(self, comment: "")
    }
    
    /// localized with uppercased style
    var uplocalized: String {
        return self.localized.uppercased()
    }
    
    func selfLocalized(for lang: String) -> String {
        if let tableName = Bundle.main.infoDictionary?["BRAND_PREFIX"] as? String,
           let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
