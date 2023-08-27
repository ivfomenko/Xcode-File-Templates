import Foundation

// MARK: - ErrorCode
enum ErrorCode: String {
    
}

// MARK: - ErrorCode: Decodable
extension ErrorCode: Decodable {
    init(from decoder: Decoder) throws {
        self = try ErrorCode(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unExpectedError
    }
}
