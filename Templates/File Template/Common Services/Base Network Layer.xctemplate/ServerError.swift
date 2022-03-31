//
//  ServerError.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

// MARK: - ServerError
/// Server Error Object
struct ServerError: Error, Decodable {
    var status: ResponseStatus
    var error: ErrorCode
    
    init(error: ResponseError, status: ResponseStatus?) {
        self.error = error
        self.status = status
    }
}

// MARK: - ServerError: Equatable
extension ServerError: Equatable {
    static func == (lhs: ServerError, rhs: ServerError) -> Bool {
        return lhs.error == rhs.error
    }
}

// MARK: - ResponseStatus
enum ResponseStatus: String, Decodable {
    case OK
    case ERROR
}

// MARK: - Error asServerError
extension Error {
    /// Method should try to map error to ServerError.
    /// If mapping will fail should return ServerError with .UNEXPECTED_ERROR code
    func asServerError() -> ServerError {
        let error = (self as? ServerError) ?? ServerError(status: .ERROR, error: .unexpected)
        return error
    }
}
