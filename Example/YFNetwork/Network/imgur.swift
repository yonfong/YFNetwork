import Foundation
import Moya
import UIKit

public enum Imgur{
  static private let clientId = "d623947a05accad"
  
  case upload(UIImage)
  case delete(String)
}

extension Imgur:TargetType{
  public var baseURL: URL {
    return URL(string: "https://api.imgur.com/3")!
  }
  
  public var path: String {
    switch self {
    case .upload: return "/image"
    case .delete(let deletehash): return "/image/\(deletehash)"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    case .delete: return .delete
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    switch self {
    case .upload(let image):
      let imageData = UIImageJPEGRepresentation(image, 1.0)!
      
      return .uploadMultipart([MultipartFormData(provider: .data(imageData),
                                                 name: "image",
                                                 fileName: "card.jpg",
                                                 mimeType: "image/jpg")])
    case .delete:
      return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    return [
      "Authorization": "Client-ID \(Imgur.clientId)",
      "Content-Type": "application/json"
    ]
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
}
