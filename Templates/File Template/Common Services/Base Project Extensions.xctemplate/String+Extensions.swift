//
//  Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import CommonCrypto
import CryptoSwift

// MARK: - String
extension String {

    /// Encodes or decodes into a base64url safe representation
    ///
    /// - Parameter on: Whether or not the string should be made safe for URL strings
    /// - Returns: if `on`, then a base64url string; if `off` then a base64 string
    func toggleBase64URLSafe(on: Bool) -> String {
        if on {
            // Make base64 string safe for passing into URL query params
            let base64url = self.replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "=", with: "")
            return base64url
        } else {
            // Return to base64 encoding
            var base64 = self.replacingOccurrences(of: "_", with: "/")
                .replacingOccurrences(of: "-", with: "+")
            // Add any necessary padding with `=`
            if base64.count % 4 != 0 {
                base64.append(String(repeating: "=", count: 4 - base64.count % 4))
            }
            return base64
        }
    }

    func pbkdf2hmac(keyPassPhrase: String = .keyPassPhrase, keySalt: String = .keySalt) throws -> String {
        guard !self.isEmpty else {
            throw AppError.unknownError
        }
        let password: [UInt8] = Array(keyPassPhrase.utf8)
        let salt: [UInt8] = Array(keySalt.utf8)
        
        let key = try PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: 65_536,
            keyLength: 32,
            variant: .sha256
        ).calculate()
        
        let iv = AES.randomIV(12)
        
        do {
            let gcm = GCM(iv: iv, mode: .combined)
            let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
            let encrypted = try aes.encrypt(self.bytes)
            let data = iv + encrypted
            return Data(data).base64EncodedString()
        } catch {
            throw error
        }
    }
    
    var isValidPassword: Bool {
        
        let passwordRegEx = "^(?=.*[a-zA-Z])((?=.*[0-9])|(?=.*[!@\\^\\$%&*()\\-_=+\\[\\];:‘“,<.>\\/?])).{8,24}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: self)
        return result
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    var isValidUserName: Bool {
        let userNameRegEx = "^\\p{letter}{1,}$"
        let userNameText = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        let result = userNameText.evaluate(with: self)
        return result
    }
    
    var isValidProductName: Bool {
        let userNameRegEx = "(?<! )[-a-zA-Z' ]{4,26}"
        let userNameText = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        let result = userNameText.evaluate(with: self)
        return result
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    /// Calculate needed height for label
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Calculates needed height for label with additional line spacing (left aligned + word wrap)
    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineSpacing spacing: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = NSTextAlignment.left
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font, .paragraphStyle: paragraphStyle], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Calculate needed width for label
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    var snakeCased: String {
        let pattern = "([a-z0-9])([A-Z])"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        let text = regex?.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: .zero, length: self.count),
            withTemplate: "$1_$2"
        )
        
        return text?.lowercased() ?? self
    }
    
    var strippingTextInParentheses: String {
        let pattern = "\\((.*?)\\)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: .zero, length: count)
        
        let text = regex?.stringByReplacingMatches(
            in: self,
            options: [],
            range: range, withTemplate: ""
        )
        
        return text ?? self
    }
    
    func remove(chars: String...) -> String {
        var temp = self
        chars.forEach { temp = temp.replacingOccurrences(of: $0, with: "") }
        return temp
    }
}
