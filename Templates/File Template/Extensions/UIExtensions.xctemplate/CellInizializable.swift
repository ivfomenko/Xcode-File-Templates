//
//  CellInizializable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

import UIKit

protocol CellInizializable {
    
    static var identifier: String { get }
    
    static var nib: UINib { get }
}

extension CellInizializable where Self: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}

extension CellInizializable where Self: UITableViewCell {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}

extension CellInizializable where Self: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
