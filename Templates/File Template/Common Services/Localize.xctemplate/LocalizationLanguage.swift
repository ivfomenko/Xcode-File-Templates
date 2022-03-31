//
//  LocalizationLanguage.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

// MARK: - LocalizationLanguage
enum LocalizationLanguage: CaseIterable {
    case English
    case Ukrainian
    
    var code: String {
        switch self {
        case .English:
            return "en"
        case .Ukrainian:
            return "uk"
        }
    }
    
    var localizedName: String {
        switch self {
        case .English:
            return "English".localized
        case .Ukrainian:
            return "Ukrainian".localized
        }
    }
    
    // returns language in english locale, e.g: German - German
    var engLocalized: String {
        return Locale(identifier: "en").localizedString(forLanguageCode: self.code) ?? ""
    }
    
    // returns language in it`s own locale, e.g: German - Deutsch
    var localizedWithSelfLocale: String {
        let name = Locale(identifier: self.code).localizedString(forLanguageCode: self.code) ?? self.engLocalized
        return name.capitalizingFirstLetter()
    }
}

// MARK: - init(from code: String)
extension LocalizationLanguage {
    
    init(from code: String) {
        switch code {
        case LocalizationLanguage.English.code:
            self = LocalizationLanguage.English
        case LocalizationLanguage.Ukrainian.code:
            self = LocalizationLanguage.Ukrainian
        default:
            self = LocalizationLanguage.Ukrainian
        }
    }
    
}
