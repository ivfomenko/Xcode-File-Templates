import Moya
import RxSwift

final class NetworkProvider {
    
    // - Private Properties
    private var provider: MoyaProvider<APIService>
    
    // - Base
    init() {
        self.provider = MoyaProvider<APIService>(plugins: [CustomNetworkLoggerPlugin(verbose: true)])
    }
    
    /*
     add here handle on 401 error
     */
    // - Publish funcs
    func request(target: APIService) -> Single<Response> {
        return privateRequest(target: target)
    }
    
    /// Parse custom JSON object, which has JSONResponse type for Rx-converted T model
    func parse<T: Decodable & JSONResponse>(data: Data, for type: T.Type) -> Single<T> {
            do {
                let response: T = try JSONDecoder().decode(type.self, from: data)
                if response.status == .ERROR {
                    let error: ServerError = try JSONDecoder().decode(ServerError.self, from: data)
                    return Single.error(error)
                } else {
                   return Single.just(response)
                }
            } catch {
                do {
                    let serverError: ServerError = try JSONDecoder().decode(ServerError.self, from: data)
                    return Single.error(serverError)
                } catch {
                    return Single.error(error)
                }
            }
        }
    
    // - Private functions
    private func privateRequest(target: APIService) -> Single<Response> {
        return provider.rx.request(target)
            .do(onSuccess: { _ in
                NetworkActivityIndicatorManager.networkOperationFinished()
            }, onError: { _ in
                NetworkActivityIndicatorManager.networkOperationFinished()
            }, onSubscribe: {
                NetworkActivityIndicatorManager.networkOperationStarted()
            })
    }
}

