//
//  FontRepresentable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//
import UIKit

public protocol FontRepresentable: RawRepresentable {}

public extension FontRepresentable where Self.RawValue == String {
    
    /// An alternative way to get a particular `UIFont` instance from a `Font`
    /// value.
    ///
    /// - parameter of size: The desired size of the font.
    ///
    /// - returns a `UIFont` instance of the desired font family and size, or
    /// `nil` if the font family or size isn't installed.
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }

    func of(size: Double) -> UIFont? {
        return UIFont(name: rawValue, size: CGFloat(size))
    }
}
