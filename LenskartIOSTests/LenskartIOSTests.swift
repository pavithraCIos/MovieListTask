//
//  LenskartIOSTests.swift
//  LenskartIOSTests
//
//  Created by pavithra on 11/12/22.
//

import XCTest
@testable import LenskartIOS

class LenskartIOSTests: XCTestCase {

    var httpClient: APIManager!
   
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_request_with_URL() {

         let url =  "http://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=1"
        APIManager.getMovieList(offset: 1, params: []) { (results, total_count) in
        }
        XCTAssert(APIManager.movieListApi(offset: 1) == url)
    }
    
//    func test_get_should_return_data() {
//
//        var actualData: MovieListModel?
//        APIManager.getMovieList(offset: 1, params: []) { (results, total_count) in
//            actualData = results
//        }
//        XCTAssertNotNil(actualData)
//    }
}
