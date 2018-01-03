//
//  SearchSearchPresenterTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import XCTest
@testable import last_fm

class SearchPresenterTest: XCTestCase {

    let presenter = SearchPresenter()
    let interactor = MockInteractor()
    let view = MockViewController()
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchOptions() {
        XCTAssertTrue(presenter.scopeBarTitles().count == 3, "Should be 3 different search options")
        XCTAssertTrue(presenter.scopeBarTitles()[0] == "Artist", "First search options should be Artist")
        XCTAssertTrue(presenter.scopeBarTitles()[1] == "Song", "Second search options should be Song")
        XCTAssertTrue(presenter.scopeBarTitles()[2] == "Album", "Third search options should be Album")
    }
    
    func testDefaultSearchOption() {
        XCTAssertTrue(presenter.selectedScopeBarTitle() == .artist,"Preselected search option should be Artist")
    }
    
    func testPresenceOfSearchScopeBar() {
        XCTAssertTrue(presenter.scopeBarPresent() == true,"Search scope bar should be present")
    }
    
    func testSearchTerm() {
        let searchFor = "Cher"
        presenter.setSearchCondition(0)
        presenter.search(term: "Cher")
        XCTAssertTrue(interactor.searchTerm == searchFor, "We should search for \(searchFor)")
        XCTAssertTrue(interactor.searchType == .artist,"Search condition should be artist")
    }
    
    
    func testNumberOfSearchMatches() {
        XCTAssertTrue(presenter.numberOfSearchMathes() == 0,"Number of matches should be 0")
        presenter.list(results: [SearchMatches(["name":"artist"],.artist)])
        XCTAssertTrue(presenter.numberOfSearchMathes() == 1,"Number of matches should be 1")
        
    }
    
    func testMatchForRow() {
        presenter.list(results: [SearchMatches(["name":"artist"],.artist)])
        let match = presenter.match(forRow: 0)
        XCTAssertTrue( match.albumName == "artist" ,"Unexpected element returned")
    }
    
    func testClearSearchResults() {
        presenter.list(results: [SearchMatches(["name":"artist"],.artist)])
        XCTAssertTrue(presenter.numberOfSearchMathes() == 1,"Number of matches should be 1")
        presenter.clearSearchResults()
        XCTAssertTrue(presenter.numberOfSearchMathes() == 0,"Number of matches should be 0")
    }
    
    func testSelectedMatch() {
        let matches = [SearchMatches(["name":"artist","mbid":"23423"],.artist),SearchMatches(["name":"artist2","mbid":"123213"],.artist)]
        let router =  MockRouter()
        presenter.router = router
        presenter.list(results: matches)
        presenter.selected(row: 1)
        XCTAssertTrue( router.selectedMatch == matches[1] , "Slected march has been passed to router" )
    }
    
/*
     func image(forRow: Int, completion: @escaping (UIImage)->Void)
     func prepare(for segue: UIStoryboardSegue)
 */
    
    class MockInteractor: SearchInteractorInput {
        func setApiHandler(_: SearchArtist) {
            
        }
        
        
        var searchTerm = ""
        var searchType:SearchCondition?
        
        func search(condition searchCondition: SearchCondition, artist: String) {
            searchType = searchCondition
            searchTerm = artist
        }
        
        func image(for match: SearchMatches, completion: @escaping (UIImage) -> Void) {
            
        }
        
        func search(artist: String) {
            
        }
        

    }

    class MockRouter: SearchRouterInput {
        func setSearchDetailsApiHandler(_ api: SearchInfo) {
            
        }
        
        
        var selectedMatch:SearchMatches?
        
        func selected(_ match: SearchMatches) {
            selectedMatch = match
        }
        
        func prepare(for segue: UIStoryboardSegue) {
            
        }
        

    }

    class MockViewController: SearchViewInput {
        func showError(_ errorMsg: String) {
            
        }
        
        func reload() {
            
        }
        
        var activityIndicatorRunning = false
        
        func startActivityIndicator() {
            activityIndicatorRunning = true
        }

        func stopActivityIndicator() {
            activityIndicatorRunning = false
        }
        

        func setupInitialState() {

        }
    }
}
