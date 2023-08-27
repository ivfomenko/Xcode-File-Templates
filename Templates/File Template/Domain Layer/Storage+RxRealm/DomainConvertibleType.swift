import Foundation

/**
 Protocol for platform's model that provide
 a unified way for converting Domain's models to Platform's models.
 */
public protocol DomainConvertibleType {
    
    // Domain's model type
    associatedtype DomainType: Decodable
    
    /// Converts Platform's model to Domain's model.
    ///
    /// - Returns: Domain's model created from current Platform's model.
    func asDomain() -> DomainType
    
    /// Converts Platform's model to Domain's model.
    ///
    /// - Parameters:
    ///     - domain: Domain's model which will be used to update Platform's model properties.
    func fromDomain(domain: DomainType)
}
