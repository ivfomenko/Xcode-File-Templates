//
//  Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import RxSwift
import RxCocoa
import CoreLocation
 
// MARK: - OptionalType
public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

// MARK: - Optional: OptionalType
extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

// MARK: - Observable where Element: OptionalType
extension Observable where Element: OptionalType {
    
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

// MARK: - PrimitiveSequenceType where Trait == CompletableTrait, Element == Never
extension PrimitiveSequenceType where Trait == CompletableTrait, Element == Never {
    
    func skipError() -> Completable {
        return self.primitiveSequence.catchError({ _ in return Completable.empty() })
    }
}

// MARK: - Reactive where Base: CLGeocoder
public extension Reactive where Base: CLGeocoder {
    
    func reverseGeocodeLocation(location: CLLocation) -> Single<[CLPlacemark]> {
        return Single.create { single -> Disposable in
            self.base.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en-EN")) { placemarks, error in
                if let placemarks = placemarks {
                    single(.success(placemarks))
                } else if let error = error {
                    single(.error(error))
                } else {
                    single(.error(AppError.unknownError))
                }
            }
            return Disposables.create()
        }
    }
}
