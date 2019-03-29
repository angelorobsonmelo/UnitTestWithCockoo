//
//  ProjectTestTests.swift
//  ProjectTestTests
//
//  Created by Stant on 29/03/19.
//  Copyright © 2019 Stant. All rights reserved.
//

import XCTest
@testable import UnitTestesWithCuckoo
import Cuckoo

class UserRepositoryTest: XCTestCase {
    
    let mock = MockUserRepository()
    
    override func setUp() {
        stub(mock) { stub in
            when(stub.getName(id: anyInt())).thenReturn("stub name")
            when(stub.getAge(id: anyInt())).thenReturn(18)
        }
    }
    
    override func tearDown() {
        
    }
    
    func testExample() {
        // Act and Assert
        XCTAssertEqual(mock.getName(id: 1), "stub name")
        XCTAssertEqual(mock.getAge(id: 1), 18)
        
        verify(mock).getName(id: 1)
        verify(mock, times(2)).getName(id: 2)
        verify(mock, never()).getName(id: anyInt())
        
    }
    
}

