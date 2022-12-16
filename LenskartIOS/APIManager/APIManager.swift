//
//  APIManager.swift
//  LenskartIOS
//
//  Created by pavithra on 11/12/22.
//

import Foundation
import UIKit

class APIManager: NSObject {
    static let pageOffset = 0
    enum GetURLParam:String {
        case query = "query="
        case page = "page="
        case ampacent = "&"
    }
    private override init() { }
    static let baseImageUrl = "http://image.tmdb.org/t/p/w92"
    static let baseUrl = "http://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f"
    
    static  func movieListApi(offset:Int)->String {
        guard var url:String =  Optional(APIManager.baseUrl) else { return ""}
        url +=  APIManager.GetURLParam.ampacent.rawValue + APIManager.GetURLParam.query.rawValue + "a%20"
        url +=  APIManager.GetURLParam.ampacent.rawValue + APIManager.GetURLParam.page.rawValue + "\(offset)"
        return url
    }
    static func getMovieList( offset: Int = APIManager.pageOffset, params: [[String:Any]]?, success:@escaping((_ MovieListModel:MovieListModel?, _ code:Int)->Void)) {
    
        RequestManager.shared.request(withEndPoint:  movieListApi(offset:offset), andndIsHeader: true, andMethod: .get, andParameter:[], andType: MovieListModel.self, andSuccess: { (data, codebleResponse) in
            if let trendingStyles = codebleResponse as? MovieListModel {
                success(trendingStyles, trendingStyles.total_results ?? 0)
                return
            }
            success(nil, RequestManager.eCode.e103.rawValue)
        }) { (code, message) in
            success(nil, code); return
        }
  
    }
}
