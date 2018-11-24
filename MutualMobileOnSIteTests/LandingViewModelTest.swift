//
//  LandingViewModelTest.swift
//  MutualMobileOnSIteTests
//
//  Created by Satyam Sehgal on 03/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import MutualMobileOnSIte

class LandingViewModelTest: XCTestCase {
    var viewModel: LandingViewModel?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         viewModel = nil
    }

    func testModelIntialisation() {
        let json: JSON = [ "albumId": 1,
                           "id": 1,
                           "title": "accusamus beatae ad facilis cum similique qui sunt",
                           "url": "https://via.placeholder.com/600/92c952",
                           "thumbnailUrl": "https://via.placeholder.com/150/92c952"
        ]

        let viewModel = LandingViewModel(json: json)
        XCTAssert(viewModel?.title == "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssert(viewModel?.url == "https://via.placeholder.com/600/92c952")
    }
}
