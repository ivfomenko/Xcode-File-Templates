//
//  Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

extension UICollectionView {
    func registerNib<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forCellWithReuseIdentifier: T.identifier
        )
    }
    
    func registerClass<T: CellInizializable & UICollectionViewCell>(_: T.Type) {
        register(
            T.self,
            forCellWithReuseIdentifier: T.identifier
        )
    }
    
    func dequeueReusableCell<T: CellInizializable>(forIndexPath indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.identifier)") }
        
        return cell
    }
    
    var centerPoint: CGPoint {
        CGPoint(
            x: center.x + contentOffset.x,
            y: center.y + contentOffset.y
        )
    }
    
    var indexPathInCenter: IndexPath? {
        indexPathForItem(at: centerPoint)
    }
}

extension UITableView {
    func registerNib<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forCellReuseIdentifier: T.identifier
        )
    }
    
    func registerClass<T: CellInizializable & UITableViewCell>(_: T.Type) {
        register(
            T.self,
            forCellReuseIdentifier: T.identifier
        )
    }
    
    func dequeueReusableCell<T: CellInizializable>(forIndexPath indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.identifier)") }
        
        return cell
    }
}
