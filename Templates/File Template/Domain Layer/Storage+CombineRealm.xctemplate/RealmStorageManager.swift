import RealmSwift
import Combine
import Combine_Realm

// MARK: - RealmStorageManager
public class RealmStorageManager {
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - RealmStorageManager: DomainStorageProtocol
extension RealmStorageManager: DomainStorageProtocol {
    
    func subscribeOnDomainObjects<T: RealmConvertableType>(realmType: T.Type, predicate: NSPredicate? = nil) -> AnyPublisher<[T.DomainType], Error> {
        do {
            let storage = try Realm()
            let objects = storage.objects(realmType.self)
            let publishers = RealmPublishers.collection(from: objects).map({ $0.toArray().compactMap({ $0.asDomain()} )}).eraseToAnyPublisher()
            return publishers
        } catch {
            return Empty().eraseToAnyPublisher()
        }
    }
    
    func getDomainObject<T: RealmConvertableType>(by key: Any, realmType: T.Type) -> Future<T.DomainType, Error> {
        do {
            let storage = try Realm()
            guard let object = storage.object(ofType: realmType.self, forPrimaryKey: key)?.asDomain() else {
                return Future { promise in
                    promise(.failure(DatabaseError.objectNotExists))
                }
            }
            return Future { promise in
                promise(.success(object))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
    
    func getDomainObjects<T: RealmConvertableType>(realmType: T.Type) -> Future<[T.DomainType], Error> {
        do {
            let storage = try Realm()
            let objects = storage.objects(T.self).toArray(ofType: T.self).compactMap({ $0.asDomain() })
            return Future { promises in
                promises(.success(objects))
                
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
    
    func getUniqueDomainObject<T: RealmConvertableType>(realmType: T.Type) -> Future<T.DomainType, Error> {
        do {
            let storage = try Realm()
            guard let object = storage.objects(T.self).first?.asDomain() else {
                return Future { promise in
                    promise(.failure(DatabaseError.objectNotExists))
                }
            }
            return Future { promise in
                promise(.success(object))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
    
    func saveDomainObject<T: RealmConvertableType>(realmType: T.Type, model: T.DomainType) -> Future<T.DomainType, Error> {
        do {
            let storage = try Realm()
            let object = realmType.init()
            object.fromDomain(domain: model)
            try storage.write {
                storage.add(object, update: .all)
            }
            return Future { promise in
                promise(.success(model))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
        
    func saveDomainObjects<T: RealmConvertableType>(realmType: T.Type, models: [T.DomainType]) -> Future<[T.DomainType], Error> {
        do {
            let database = try Realm()
            let objects = models.compactMap { model -> T in
                let object = realmType.init()
                object.fromDomain(domain: model)
                return object
            }
            try database.write {
                database.add(objects, update: .all)
            }
            return Future { promise in
                promise(.success(models))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
    
    func removeDomainObjects<T: RealmConvertableType>(realmType: T.Type, with keys: [Any]) -> Future<[T.DomainType], Error> {
        do {
            let database = try Realm()
            let objects = keys.compactMap { database.object(ofType: T.self, forPrimaryKey: $0) }
            let domainObjects = objects.map { $0.asDomain() }
            
            try database.write {
                database.delete(objects)
            }
            
            return Future { promise in
                promise(.success(domainObjects))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
}

// MARK: - RealmStorageManager: RealmStorageProtocol
extension RealmStorageManager: RealmStorageProtocol {
    func setRealmObject<T>(realmModel: T) -> Future<T, Error> where T: Object {
        do {
            let storage = try Realm()
            try storage.write {
                storage.add(realmModel, update: .all)
            }
            return Future { promise in
                promise(.success(realmModel))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.saveFailed(realmModel.description)))
            }
        }
    }
    
    func deleteRealmObject<T>(realmModel: T) -> Future<T, Error> where T: Object {
        do {
            let storage = try Realm()
            try storage.write {
                storage.delete(realmModel)
            }
            return Future { promise in 
                promise(.success(realmModel))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.deleteFailed(realmModel.description)))
            }
        }
    }
    
    func getRealmObjects<T>(type: T.Type) -> Future<[T], Error> where T: Object {
        do {
            let storage = try Realm()
            let objects = storage.objects(T.self).toArray(ofType: T.self)
            return Future { promise in
                promise(.success(objects))
            }
        } catch {
            return Future { promise in
                promise(.success([]))
            }
        }
    }
    
    func getRealmObject<T>(type: T.Type, primaryKey: Any) -> Future<T, Error> where T: Object {
        do {
            let storage = try Realm()
            let object = storage.object(ofType: T.self, forPrimaryKey: primaryKey)
            guard let realmObject = object else {
                return Future { promise in
                    promise(.failure(DatabaseError.objectNotExists))
                }
            }
            return Future { promise in
                promise(.success(realmObject))
            }
        } catch {
            return Future { promise in
                promise(.failure(DatabaseError.objectNotExists))
            }
        }
    }
    
    func deleteAllObject() {
        do {
            let storage = try Realm()
            try storage.write {
                storage.deleteAll()
            }
        } catch {}
    }
}
