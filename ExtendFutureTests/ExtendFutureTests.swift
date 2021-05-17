//
//  ExtendFutureTests.swift
//  ExtendFutureTests
//
//  Created by Cao Phuoc Thanh on 15/05/2021.
//

import XCTest
import Combine
@testable import ExtendFuture

class ExtendFutureTests: XCTestCase {
    
    func plusInt(a: Int, b: Int) -> Future<Int, Never> {
        return Future<Int, Never> { promise in
            promise(.success(a+b))
        }
    }

    func plusFloat(a: Float, b: Float) -> Future<Float, Never> {
        return Future<Float, Never> { promise in
            promise(.success(a+b))
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAwait() throws {
       
        // Future Await extension
        let a = try! plusInt(a: 4, b: 5).await()
        let b = try! plusFloat(a: 3, b: 5).await()

        let c = Float(a) + b
        
        XCTAssertEqual(a, 9, "wrong")
        XCTAssertEqual(b, 8, "wrong")
        XCTAssertEqual(c, 17, "wrong")
    }
    
    func testThen() throws {
        
        // Future Then extension
        let d = try! plusInt(a: 1, b: 1)
            .then {
                self.plusFloat(a: Float($0), b: 3)
            }
            .then {
                self.plusFloat(a: $0, b: 1)
            }
            .await()


        XCTAssertEqual(d, 6, "wrong")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
