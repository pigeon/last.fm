//
//  DetailsDetailsPresenterTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import XCTest
@testable import last_fm

class DetailsPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: DetailsInteractorInput {
        func getInfo(_ match: SearchMatches) {
            
        }
        
        func setSearchDetailsApiHandler(_ api: SearchInfo) {
            
        }
        

    }


    class MockViewController: DetailsViewInput {
        func setInfo(_: MatchInfo) {
            
        }
        
        func setInfoImage(_: UIImage) {
            
        }
        

        func setupInitialState() {

        }
    }
}
