//
//  UITestObjectMapperTransformStringToDate.swift
//  Demo
//
//  Created by Sergey Suslov on 27.11.16.
//  Copyright © 2016 SS. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Demo
class TestOM: Mappable {
    var dd: Date? = nil
    required init?(map: Map) {
    }
    
    init() {
    }
    func mapping(map: Map) {
        dd <- (map["dd"], ObjectMapperTransformStringToDate())
    }
}

class TestObjectMapperTransformStringToDate: XCTestCase {
    
    func testFromJson() {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let d = df.date(from: "2016-01-01 00:00:00")
        XCTAssertNotNil(d)
        
        let testO = Mapper<TestOM>().map(JSON: ["dd": "2016-01-01T00:00:00.000+00:00"])
        XCTAssertNotNil(testO)
        XCTAssertNotNil(testO?.dd)
        XCTAssertEqual(d!, testO!.dd!)
    }
    
    func testToJson() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let d = df.date(from: "2016-01-01 00:00:00")
        XCTAssertNotNil(d)
        
        let dfO = DateFormatter()
        dfO.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        let dO = dfO.string(from: d!)
        
        
        let t = TestOM()
        XCTAssertNotNil(t)
        t.dd = d
        XCTAssertNotNil(t.dd)
        let jsonOutput = t.toJSON()
        XCTAssertNotNil(jsonOutput)
        let dd = jsonOutput["dd"]
        XCTAssertNotNil(dd)
        XCTAssertTrue(dd is String)
        XCTAssertEqual(dd! as! String, dO )
    }
}
