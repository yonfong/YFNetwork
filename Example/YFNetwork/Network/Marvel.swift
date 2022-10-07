import Foundation
import Moya
import YFNetwork
import MoyaCache
import Storable

public enum Marvel{
  static private let publicKey = "b37b1ebf30b3e2e827d82411fa48c7a9"
  static private let privateKey = "6861448250aafb20fc436081f2063bb75004e635"
  
  case comics
}

extension Marvel:TargetType {
  public var baseURL: URL {
    return URL(string: "https://gateway.marvel.com/v1/public")!
  }
  
  public var path: String {
    switch self {
    case .comics:  return "/comics"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .comics: return .get
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    let ts = "\(Date().timeIntervalSince1970)"
    // 1
    let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
    
    // 2
    let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
    
    switch self {
    case .comics:
      // 3
      return .requestParameters(
        parameters: [
          "format": "comic",
          "formatType": "comic",
          "orderBy": "-onsaleDate",
          "dateDescriptor": "lastWeek",
          "limit": 50] + authParams,
        encoding: URLEncoding.default)
    }
  }
  
  public var headers: [String : String]? {
    return ["Content-Type":"application/json"]
  }
  
  //获得或者设置用于指定所执行的验证类型的值
  public var validationType:ValidationType{
    return .successCodes  //HTTP code 200-299
  }
}

extension Marvel: Networkable {
    public typealias Target = Self
    
//    public static var provider: MoyaProvider<Target> {
//        get {
//            let myEndpointClosure = { (target: TargetType) -> Endpoint in
//                let url = target.baseURL.absoluteString + target.path
//                let task = target.task
//
//                let endpoint = Endpoint(
//                    url: url,
//                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//                    method: target.method,
//                    task: task,
//                    httpHeaderFields: target.headers
//                )
//                return endpoint
//            }
//
//            let myRequestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
//                do {
//                    var request = try endpoint.urlRequest()
//                    request.timeoutInterval = 30
//                    done(.success(request))
//                } catch {
//                    done(.failure(MoyaError.underlying(error, nil)))
//                }
//            }
//
//            return MoyaProvider<Target>(endpointClosure: myEndpointClosure, requestClosure: myRequestClosure, plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))], trackInflights: false)
//        }
//    }
}

extension Marvel: Cacheable {
    public var expiry: Expiry {
        return .never
    }
}

