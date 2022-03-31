//
//  DatabaseProtocols.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import Combine
import RealmSwift

protocol DomainStorageProtocol {
    /// typealias for realm model
    typealias RealmConvertableType = Object & DomainConvertibleType
    
    /// Get domain object (Decodable) in Future container. Set key and needed realm type (which must be mirrow for you decodable model)
    func getDomainObject<T: RealmConvertableType>(by key: Any, realmType: T.Type) -> Future<T.DomainType, Error>
    
    /// Get all domain objects (Decodable) in data base. Data will be in Future container. Set key and needed realm type (which must be mirrow for you decodable model)
    func getDomainObjects<T: RealmConvertableType>(realmType: T.Type) -> Future<[T.DomainType], Error>
    
    /// Get unique domain objects (Decodable) in data base. Data will be in Future container. Set key and needed realm type (which must be mirrow for you decodable model)
    func getUniqueDomainObject<T: RealmConvertableType>(realmType: T.Type) -> Future<T.DomainType, Error>
    
    /// Save  domain object (Decodable) in data base. Return saved data in Future container. Set model and needed realm type (which must be mirrow for you decodable model)
    func saveDomainObject<T: RealmConvertableType>(realmType: T.Type, model: T.DomainType) -> Future<T.DomainType, Error>
    
    /// Save  domain objects (Decodable) in data base. Return  saved data in Future container. Set model and needed realm type (which must be mirrow for you decodable model)
    func saveDomainObjects<T: RealmConvertableType>(realmType: T.Type, models: [T.DomainType]) -> Future<[T.DomainType], Error>
    
    /// Remove  domain objects (Decodable) in data base. Return deleted data in Future container. Set model and needed realm type (which must be mirrow for you decodable model)
    func removeDomainObjects<T: RealmConvertableType>(realmType: T.Type, with keys: [Any]) -> Future<[T.DomainType], Error>
    
    /// Subscribe on  domain objects (Decodable) in data base. Return  data in AnyPublisher container. Set predicate (if needed) and needed realm type (which must be mirrow for you decodable model)
    func subscribeOnDomainObjects<T: RealmConvertableType>(realmType: T.Type, predicate: NSPredicate?) -> AnyPublisher<[T.DomainType], Error>
}

protocol RealmStorageProtocol {
    /// Set Realm Object to Data Base
    ///
    /// - Parameter realmModel: Realm Object to save
    func setRealmObject<T: Object>(realmModel: T) -> Future<T, Error>
    
    /// Delete Realm Object by id
    ///
    /// - Parameter realmModel: Realm Object to save
    func deleteRealmObject<T: Object>(realmModel: T) -> Future<T, Error>
    
    /// Get Array of Realm Objects
    /// - Parameter type: Realm model.self type, which you need to get
    func getRealmObjects<T: Object>(type: T.Type) -> Future<[T], Error>
    
    /// Get Realm Object by Primary key
    ///
    /// - Parameter primaryKey: Primary key of model, which you need. You can set it as String or Int
    func getRealmObject<T: Object>(type: T.Type, primaryKey: Any) -> Future<T, Error>
    
    /// Clean Realm Data Base
    func deleteAllObject()
}
