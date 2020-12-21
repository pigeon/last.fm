//
//  DetailsDetailsInteractorTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import XCTest
@testable import last_fm

class DetailsInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: DetailsInteractorOutput {
        func info(_: MatchInfo) {
            
        }
        
        func image(_: UIImage) {
            
        }
        

    }
}
