//
//  UnitTestesWithCuckooTests.swift
//  UnitTestesWithCuckooTests
//
//  Created by Stant on 29/03/19.
//  Copyright © 2019 Stant. All rights reserved.
//

import XCTest
@testable import UnitTestesWithCuckoo
import Cuckoo

class UrlSessionTest: XCTestCase {

    let mock = MockUrlSession()
    var urlStr = "https://riis.com"
    var url: URL?
    
    override func setUp() {
        url  = URL(string:urlStr)!
        
        stub(mock) { (mock) in
            when(mock.apiUrl).get.thenReturn(urlStr)
        }
        
        stub(mock) { (mock) in
            when(mock.url).get.thenReturn(url)
        }
        
        stub(mock) { (mock) in
            when(mock.session).get.thenReturn(URLSession())
        }
        stub(mock) { (stub) in
            stub.getSourceUrl(apiUrl: urlStr).thenReturn(url!)
        }
        
        stub(mock) { mock in
            mock.callApi(url: equal(to:url!, equalWhen: { $0 == $1 })).thenReturn("{'firstName': 'John','lastName': 'Smith'}")
        }
    }
    
    override func tearDown() {
        
    }
    
    func testExample() {
        // Act and Assert
        XCTAssertEqual(mock.apiUrl, urlStr)
        XCTAssertEqual(mock.url?.absoluteString, urlStr)
        XCTAssertNotNil(mock.session)
        XCTAssertEqual(mock.callApi(url: url!),"{'firstName': 'John','lastName': 'Smith'}")
        
        XCTAssertNotNil(verify(mock).session)
        XCTAssertNotNil(verify(mock).apiUrl)
        XCTAssertNotNil(verify(mock).url)
    }

}
