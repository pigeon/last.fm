//
//  SearchSearchInteractorTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import XCTest
@testable import last_fm


class SearchInteractorTests: XCTestCase {

    let interactor = SearchInteractor()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testApiHandlerConfiguration() {
        let presenter = MockPresenter()
        interactor.output = presenter
        interactor.search(condition: .artist, artist: "Cher")
        XCTAssertNotNil(presenter.searchError,"Error shouldn't be nil")
        XCTAssertTrue(presenter.searchError!.localizedDescription == "API handler init has failed","Unexpected error")
    }
    
    func testSearchFailure() {
        let presenter = MockPresenter()
        interactor.setApiHandler(MockedAPI(false))
        interactor.output = presenter
        interactor.search(condition:.artist, artist: "search")
        XCTAssertNotNil(presenter.searchError,"Error should be set")
    }
    
    func testSearchSuccess() {
        let presenter = MockPresenter()
        interactor.setApiHandler(MockedAPI(true))
        interactor.output = presenter
        interactor.search(condition:.artist, artist: "search")
        XCTAssertNil(presenter.searchError,"Error shouldn't be set")
        XCTAssertTrue(presenter.results?.count == 1,"Should be one element in array")
    }
    

    class MockedAPI : SearchArtist {
        
        let searchResult:Bool
        
        init(_ success:Bool) {
            searchResult = success
        }
        
        func search(mode: SearchCondition, artist: String, result: @escaping ResultBlock) {
            if searchResult == true {
                result([SearchMatches(["name":"artist"],.artist)], nil)
            } else {
                result([],NSError(domain: "search has failed", code: Int.max-3, userInfo: [NSLocalizedDescriptionKey:"Asearch has failed"]))
            }
        }
    }
    
    class MockPresenter: SearchInteractorOutput {
        var searchError:Error?
        var results:[SearchMatches]?
        
        func searchFailed(error: Error?) {
            searchError = error 
        }
        
        func list(results artists: [SearchMatches]) {
            results = artists
        }
        

    }
}
