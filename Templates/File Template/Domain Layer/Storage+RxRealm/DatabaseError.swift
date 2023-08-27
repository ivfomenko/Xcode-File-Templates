import Foundation

public enum DatabaseError: Error {
    case unexpectedError
    case saveFailed(String)
    case deleteFailed(String)
    case objectNotExists
}
