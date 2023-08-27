import Foundation
import RealmSwift
import RxSwift
import RxRealm

public struct DatabaseChangeset {
    let deleted: [Int]
    let inserted: [Int]
    let updated: [Int]
}

typealias RealmObjectsObservingResult<T: DomainConvertibleType> = (objects: [T.DomainType], changeset: DatabaseChangeset)
typealias DatabaseObjectsObservingResult<T> = (objects: [T], changeset: DatabaseChangeset)

// MARK: - RealmStorageManager
public class RealmStorageManager {
    private let bag = DisposeBag()
}

// MARK: - RealmStorageManager: RealmStorageProtocol
extension RealmStorageManager: RealmStorageProtocol {
    
    func setRealmObject<T>(realmModel: T) -> PrimitiveSequence<SingleTrait, T> where T: Object {
        do {
            let storage = try Realm()
            try storage.write {
                storage.add(realmModel, update: .all)
            }
            return Single.just(realmModel)
        } catch {
            return Single<T>.error(DatabaseError.saveFailed(String(describing: T.self)))
        }
        
    }
    
    func deleteRealmObject<T>(realmModel: T) -> Completable where T: Object {
        do {
            let storage = try Realm()
            try storage.write {
                storage.add(realmModel, update: .all)
            }
            return Completable.empty()
        } catch {
            return Completable.error(DatabaseError.deleteFailed(String(describing: T.self)))
        }
    }
    
    func getRealmObjects<T>(type: T.Type) -> PrimitiveSequence<SingleTrait, [T]> where T: Object {
        do {
            let storage = try Realm()
            return Single.just(storage.objects(T.self).toArray(ofType: T.self))
            
        } catch {
            return Single.error(DatabaseError.objectNotExists)
        }
    }
    
    func getRealmObject<T>(type: T.Type, primaryKey: String) -> PrimitiveSequence<SingleTrait, T> where T: Object {
        do {
            let storage = try Realm()
            let object = storage.object(ofType: T.self, forPrimaryKey: primaryKey)
            guard let realmObject = object else {
                return Single.error(DatabaseError.objectNotExists)
            }
            return Single.just(realmObject)
        } catch {
            return Single.error(DatabaseError.objectNotExists)
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

// MARK: - RealmStorageManager: DomainStorageProtocol
extension RealmStorageManager: DomainStorageProtocol {
    
    func getUniqueDomainObject<T>(realmType: T.Type) -> PrimitiveSequence<SingleTrait, T.DomainType> where T: Object, T: DomainConvertibleType {
        do {
            let storage = try Realm()
            guard let object = storage.objects(T.self).first else {
                return Single.error(DatabaseError.objectNotExists)
            }
            return Single.just(object.asDomain())
        } catch {
            return Single.error(DatabaseError.unexpectedError)
        }
    }
    
    func getDomainObject<T: RealmConvertableType>(by key: Any, realmType: T.Type) -> Single<T.DomainType> {
        do {
            let storage = try Realm()
            guard let object = storage.object(ofType: realmType.self, forPrimaryKey: key) else {
                return Single.error(DatabaseError.objectNotExists)
            }
            return Single.just(object.asDomain())
        } catch {
            return Single.error(DatabaseError.unexpectedError)
        }
    }
    
    func getDomainObjects<T: RealmConvertableType>(realmType: T.Type) -> Single<[T.DomainType]> {
        do {
            let storage = try Realm()
            let objects = storage.objects(T.self).toArray(ofType: T.self).compactMap({ $0.asDomain() })
            return Single.just(objects)
        } catch {
            return Single.error(DatabaseError.unexpectedError)
        }
    }
    
    func setDomainObject<T: RealmConvertableType>(realmType: T.Type, model: T.DomainType) -> Completable {
        do {
            let storage = try Realm()
            let object = realmType.init()
            object.fromDomain(domain: model)
            try storage.write {
                storage.add(object, update: .all)
            }
            return Completable.empty()
        } catch {
            return Completable.error(DatabaseError.saveFailed(String(describing: T.self)))
        }
    }
    
    func setDomainObjects<T: RealmConvertableType>(realmType: T.Type, models: [T.DomainType]) -> Completable {
        do {
            let database = try Realm()
            let objects = models.compactMap { model -> T in
                let object = realmType.init()
                object.fromDomain(domain: model)
                return object
            }
            try database.write {
                database.add(objects, update: .modified)
            }
            return Completable.empty()
        } catch {
            return Completable.error(DatabaseError.saveFailed(String(describing: T.self)))
        }
    }
    
    func removeDomainObject<T: RealmConvertableType>(relmType: T.Type, primaryKey: String) -> Completable {
        do {
            let storage = try Realm()
            guard let object = storage.object(ofType: T.self, forPrimaryKey: primaryKey) else {
                return Completable.error(DatabaseError.objectNotExists)
            }
            try storage.write {
                storage.delete(object)
            }
            return Completable.empty()
        } catch {
            return Completable.error(DatabaseError.unexpectedError)
        }
    }
    
    func removeDomainObject<T: RealmConvertableType>(relmType: T.Type, primaryKey: Int) -> Completable {
        do {
            let storage = try Realm()
            guard let object = storage.object(ofType: T.self, forPrimaryKey: primaryKey) else {
                return Completable.error(DatabaseError.objectNotExists)
            }
            try storage.write {
                storage.delete(object)
            }
            return Completable.empty()
        } catch {
            return Completable.error(DatabaseError.unexpectedError)
        }
    }
    
    func removeDomainObjects<T: RealmConvertableType>(realmType: T.Type, primaryKeys: [Any]) -> Single<[T.DomainType]> {
        do {
            let database = try Realm()
            let objects = primaryKeys.compactMap { database.object(ofType: T.self, forPrimaryKey: $0) }
            let domainObjects = objects.map { $0.asDomain() }
            try database.write {
                database.delete(objects)
            }
            return Single.just(domainObjects)
        } catch {
            return Single.error(error)
        }
    }
    
    func subscribeOnDomainObjects<T>(realmType: T.Type, predicate: NSPredicate? = nil) -> Observable<RealmObjectsObservingResult<T>> where T: Object, T: DomainConvertibleType {
        do {
            let database = try Realm()
            var objects = database.objects(realmType.self)
            if let predicateVal = predicate {
                objects = objects.filter(predicateVal)
            }
            
            return Observable.arrayWithChangeset(from: objects)
                .flatMap { results, changeset -> Observable<RealmObjectsObservingResult<T>> in
                    guard let changeset = changeset else {
                        let controlArray = results.compactMap({ $0.asDomain() })
                        let emptyChangeset = DatabaseChangeset(deleted: [], inserted: [], updated: [])
                        return Observable.just((controlArray, emptyChangeset))
                    }
                    let databaseChangeset = DatabaseChangeset(deleted: changeset.deleted,
                                                              inserted: changeset.inserted,
                                                              updated: changeset.updated)
                    let domainResults = results.compactMap { $0.asDomain() }
                    return Observable.just((domainResults, databaseChangeset))
                }
        } catch {
            return Observable.empty()
        }
        
    }
}
