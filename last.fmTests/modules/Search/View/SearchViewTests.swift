//
//  SearchSearchViewTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import XCTest
@testable import last_fm


class SearchViewTests: XCTestCase {

    let view = SearchViewController()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testScopeBarPresent() {
        let presenter = MockPresenter()
        view.output = presenter
        view.createSearchBar()
        XCTAssertTrue(presenter.scopeBarPresentCalled == true,"scopeBarPresent should get called")
    }
    
    func testCelarSearchResults() {
        let presenter = MockPresenter()
        view.output = presenter
        view.clearSearchResults()
        XCTAssertTrue(presenter.clearSearchResultsCalled == true,"clearSearchResults should get called")

    }
    
    func testSearch() {
        let presenter = MockPresenter()
        let searchBar = UISearchBar()
        let searchTerm = "text"
        searchBar.text = searchTerm
        view.searchBar = searchBar
        view.output = presenter
        view.searchBarSearchButtonClicked(searchBar)
        XCTAssertTrue(presenter.searchTerm == searchTerm,"search term should be \(searchTerm)")
    }
    
    func testSearchCondition() {
        let presenter = MockPresenter()
        let searchBar = UISearchBar()
        view.searchBar = searchBar
        view.output = presenter
        view.searchBar(searchBar, selectedScopeButtonIndexDidChange: 1)
        XCTAssertTrue(presenter.searchCondition == 1,"Wrong search condition selected")
    }
    
    class MockPresenter : SearchViewOutput {
        
        var scopeBarPresentCalled = false
        var clearSearchResultsCalled = false
        var searchTerm = ""
        var searchCondition = -1
        
        func viewIsReady() {
            
        }
        
        func scopeBarPresent() -> Bool {
            scopeBarPresentCalled = true
            return false
        }
        
        func scopeBarTitles() -> [String] {
            return [""]
        }
        
        func selectedScopeBarTitle() -> SearchCondition {
            return .artist
        }
        
        func search(term: String) {
            searchTerm = term
        }
        
        func setSearchCondition(_ condition: Int) {
            searchCondition = condition
        }
        
        func numberOfSearchMathes() -> Int {
            return 0
        }
        
        func match(forRow: Int) -> SearchMatches {
            return SearchMatches([:], .artist)
        }
        
        func image(forRow: Int, completion: @escaping (UIImage) -> Void) {
            
        }
        
        func clearSearchResults() {
            clearSearchResultsCalled = true
        }
        
        func selected(row: Int) {
            
        }
        
        func prepare(for segue: UIStoryboardSegue) {
            
        }
        
        
    }
}
