//
//  API+Base.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation
import Moya

extension API {
    static let user = Provider(User.self)
    static let newsCenter = Provider(NewsCenter.self)
    static let home = Provider(Home.self)
    static let quan = Provider(Quan.self)
    static let goods = Provider(Goods.self)
    
    
    
    
    static let order = Provider(Order.self)
    static let cart = Provider(Cart.self)
}

protocol BaseTarget: TargetType {}
extension BaseTarget {
    
    var commonParameters: [String: Any] {
        let params: [String: Any] = [:]
//        params["Accept"] = "application/json"
        return params
    }
    
    var path: String {
        return ""
    }
    
    var baseURL: URL {
        return URL(string: Constant.BaseUrl)!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
        return headers
    }

}

protocol ProviderType: AnyObject {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get set }
}

public final class API {
    
    public class Provider<Target: TargetType>: ProviderType {
        
        var provider: MoyaProvider<Target>
        
        public enum Option {
            case endpoint(MoyaProvider<Target>.EndpointClosure)
            case request(MoyaProvider<Target>.RequestClosure)
            case stub(MoyaProvider<Target>.StubClosure)
            case callbackQueue(DispatchQueue?)
            case session(Session)
            case plugins([PluginType])
            case trackInflights(Bool)
        }
        
        init(_ target: Target.Type, options: [Option] = []) {
            /// 定义闭包对象
            var endpointClosure: MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping
            /// 定义request对象
            var requestClosuer = { (endpoint:Endpoint, done: @escaping MoyaProvider<Target>.RequestResultClosure) in
                do {
                    var request = try endpoint.urlRequest()
                    //  设置请求超时时间
                    request.timeoutInterval = 20
                    done(.success(request))
                } catch {
                    return
                }
            }
            
            var stubClosure: MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub
            
            /// 传播到Alamofire作为回调队列。 如果为nil - 将使用Alamofire默认（从2017年的API - 主队列）。
            var callbackQueue: DispatchQueue? = nil
            /// moya插件
            let loggerPlugin = NetworkLoggerPlugin()
            loggerPlugin.configuration.logOptions = .default
            var defaultPlugins: [PluginType] = [loggerPlugin]
            /// 是否要跟踪重复网络请求
            var isTrackInflights = false
            /// 定义会话对象
            var defaultSession: Session = MoyaProvider<Target>.defaultAlamofireSession()
            
            options.forEach { (option) in
                switch option {
                case .endpoint(let closure):
                    endpointClosure = closure
                case .request(let closure):
                    requestClosuer = closure
                case .session(let session):
                    defaultSession = session
                case .plugins(let plugins):
                    defaultPlugins = plugins
                case .stub(let closuer):
                    stubClosure = closuer
                case .trackInflights(let trackInflights):
                    isTrackInflights = trackInflights
                case .callbackQueue(let queue):
                    callbackQueue = queue
                }
            }
            
            /// 初始化 provider.
            self.provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                                 requestClosure: requestClosuer,
                                                 stubClosure: stubClosure,
                                                 callbackQueue: callbackQueue,
                                                 session: defaultSession,
                                                 plugins: defaultPlugins,
                                                 trackInflights: isTrackInflights)
        }
    }
}

extension API.Provider: ReactiveCompatible {}
extension Reactive where Base: ProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.provider.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                //  网络请求成功
                case let .success(response):
                    //  方便查看json数据
                    let jsonStr = String(data: response.data, encoding: .utf8)
                    let _ = jsonStr
                    //  code = 200
                    if response.statusCode == 200 {
                        return single(.success(response))
                    } else {
                        //  没有登录
                        if response.statusCode == 225 {
                            UserPreference.shared.logout()
                            return single(.error(LYRequestError.notLogin))
                        } else if response.statusCode == 404 {
                            return single(.error(LYRequestError.failure))
                        } else {
                            //  服务器返回错误message
                            let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any]
                            let message = json?["message"] as? String
                            let error = LYRequestError.serverError(message)
                            return single(.error(error))
                        }
                    }
                //  网络请求失败
                case let .failure(error):
                    LYPrint(error)
                    single(.error(LYRequestError.failure))
                    //  这里可以处理,做一些延迟继续请求等操作
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}


