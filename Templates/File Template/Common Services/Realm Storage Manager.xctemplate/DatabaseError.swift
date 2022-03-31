//
//  DatabaseError.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

enum DatabaseError: Error {
    case unexpectedError
    case saveFailed(String)
    case deleteFailed(String)
    case objectNotExists
}
