//
//  RequestManager.swift
//  LenskartIOS
//
//  Created by pavithra on 15/12/22.
//

import Foundation
import UIKit

class RequestManager: NSObject {
    
    enum Method {
        case post
        case put
        case get
        case delete
        case none
    }
    
    enum eCode:Int {
        //MARK:- e101 - 101
        /// "URL is invalide"
        case e101 = 101
        //MARK:- e102 = 102
        /// "Something went wrong!"
        case e102 = 102
        //MARK:- e103 = 103
        /// "Invalid resopnse!"
        case e103 = 103
        //MARK:- e104 = 104
        /// "Could not parse data!"
        case e104 = 104
        //MARK:- e105 = 105
        /// "Data not available"
        case e105 = 105
        //MARK:- e106 = 106
        /// "Network not available"
        case e106 = 106
        
        var description:String {
            switch self {
            case .e101:
                return "URL is invalide"
            case .e102:
                return "Something went wrong!"
            case .e103:
                return "Invalid resopnse!"
            case .e104:
                return "Could not parse data!"
            case .e105:
                return "Data not available"
            case .e106:
                return "Please check you internet connection."
            default:
                return ""
            }
        }
    }
    typealias Success = ((Data, Any)->Void)
    typealias Failure = ((Int, String)->Void)
    
    static let shared:RequestManager = RequestManager()
    private override init() {}
    
    func request<T: Codable>(withEndPoint strEndPoint:String, andndIsHeader isHeader:Bool, andMethod method:RequestManager.Method, andParameter parameter:Any, andType type: T.Type, andSuccess success:@escaping(Success), andFailure failure:@escaping(Failure)) {
        
        let strURL =  strEndPoint
        print("URL : \(strURL)\nMethod : \(method)\nParameter : \(parameter)\n");
        guard case var request:URLRequest = URLRequest(url: URL(string: strURL) ?? URL(string: "https://")!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 300) else { failure(RequestManager.eCode.e101.rawValue, RequestManager.eCode.e101.description); return }
        
        switch method {
        case .post:
            request.httpMethod = "POST"
            if let postData:Data = try? JSONSerialization.data(withJSONObject: parameter, options:[]) {
                request.httpBody = postData
            }
            break
        case .put:
            request.httpMethod = "PUT"
            break
        case .get:
            request.httpMethod = "GET"
            break
        case .delete:
            request.httpMethod = "DELETE"
            break
        default:
            break
        }
        
        if isHeader {
            request.setValue("application/json", forHTTPHeaderField:"Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
//        //add device token in header
//        if let deviceId:String = Optional(UIDevice.current.identifierForVendor?.uuidString ?? "") {
//            request.setValue(deviceId, forHTTPHeaderField: "Device-id")
//        }

        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { failure(RequestManager.eCode.e102.rawValue, error?.localizedDescription ?? RequestManager.eCode.e102.description); return }
                guard let data = data else { failure(RequestManager.eCode.e103.rawValue, RequestManager.eCode.e103.description); return  }
                let jsonDecoder = JSONDecoder()
                do {
                    print(String(data: data, encoding: .utf8) ?? "")
                    let parseResponse = try jsonDecoder.decode(T.self, from: data)
                    if data.count > 0 {
                        success(data, parseResponse)
                    }else {
                        failure(RequestManager.eCode.e105.rawValue, RequestManager.eCode.e105.description)
                    }
                    return
                } catch DecodingError.typeMismatch( _, let context) {
                    print("DecodingError.typeMismatch: \(context.debugDescription)")
                    print("DecodingError.Context: codingPath:")
                    for i in 0..<context.codingPath.count { print(" [\(i)] = \(context.codingPath[i])") }
                    failure(RequestManager.eCode.e104.rawValue, RequestManager.eCode.e104.description)
                    return
                } catch let err {
                    print(err.localizedDescription)
                    failure(RequestManager.eCode.e104.rawValue, RequestManager.eCode.e104.description)
                    return
                }
            }
        }.resume()
    }
}
