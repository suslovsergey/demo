//
//  TestApiClient.swift
//  Demo
//
//  Created by Sergey Suslov on 28.11.16.
//  Copyright © 2016 SS. All rights reserved.
//

import XCTest
import PromiseKit
import Log
import OHHTTPStubs
@testable import Demo
public let Log = Logger()

class TestApiClient: XCTestCase {
    // No date test :(
    func testGetPosts() {
        stub(condition: isHost("infotech-test.herokuapp.com")) { _ in
            let obj = [[
                "id": UInt(123),
                "user_pic_url": "testUrl",
                "name": "testName",
                "body": "testBody"
                ]]
            return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        }
        
        let expectation = self.expectation(description: "ModelPost Get Posts")
        ApiClient.posts()
            .then {r -> Void in
                XCTAssertNotNil(r.result)
                XCTAssertNotNil(r.result?.data)
                XCTAssertEqual(r.result!.data.count, 1)
                let o = r.result!.data[0]
                XCTAssertNotNil(o)
                XCTAssertEqual(o.body, "testBody")
                XCTAssertEqual(o.name, "testName")
                XCTAssertEqual(o.userPicUrl, "testUrl")
                XCTAssertEqual(o.id, 123)
                expectation.fulfill()
            }.catch {
                XCTFail($0.localizedDescription)
                Log.error($0)
        }
        
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}
