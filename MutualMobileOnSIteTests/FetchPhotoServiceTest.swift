//
//  FetchPhotoServiceTest.swift
//  MutualMobileOnSIteTests
//
//  Created by Satyam Sehgal on 03/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import MutualMobileOnSIte

class MockFetchPhotoService: FetchFeedServiceProtocol {
    var responseString: String? = nil
    func fetchPhoto(withURL url: URL, completionHandler: @escaping (NetworkResult) -> Void) {
        if let data = responseString?.data(using: .utf8),
            let json = try? JSON.init(data: data) {
            completionHandler(NetworkResult.success(json))
        }
        else {
            completionHandler(NetworkResult.failure(NetworkError.fetchError))
        }
    }
}

class FetchPhotoServiceTest: XCTestCase {
    var mockService: MockFetchPhotoService?
    override func setUp() {
        mockService = MockFetchPhotoService()
    }

    override func tearDown() {
        mockService = nil
    }

    func testFetchPhotoServiceSuccess() {
        mockService!.responseString = """
        [
        {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
        }
        ]
        """
        mockService!.fetchPhoto(withURL: URL.init(string: "www.google.com")!) { (result) in
            var isNetWorkResultSuccess = false
            switch result {
            case .success(_):
                isNetWorkResultSuccess = true
            case .failure(_):
                isNetWorkResultSuccess = false
            }
            XCTAssert(isNetWorkResultSuccess == true , "Failed")
        }
    }


    func testFetchPhotoServiceFailure() {
        mockService!.responseString = nil
        mockService!.fetchPhoto(withURL: URL.init(string: "www.google.com")!) { (result) in
            var networkFailureError : NetworkError?
            switch result {
            case .success(_):
                networkFailureError = nil
            case .failure(let error):
                networkFailureError = error
            }
            XCTAssert(networkFailureError == NetworkError.fetchError , "Failed")
        }
    }
}
