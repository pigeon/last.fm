//
//  SearchSearchPresenter.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

enum SearchCondition:Int {
    case artist = 0
    case song = 1
    case album = 2
}

class SearchPresenter  {
    
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
    var searchCondition:SearchCondition = .artist
    var searchMatches = [SearchMatches]()
}

extension SearchPresenter : SearchModuleInput {
    func setSearchDetailsApiHandler(_ api: SearchInfo) {
        self.router.setSearchDetailsApiHandler(api)
    }
    
    func setSearchApiHandler(_ api : SearchArtist) {
        interactor.setApiHandler(api)
    }
}

extension SearchPresenter : SearchViewOutput {
    
    func prepare(for segue: UIStoryboardSegue) {
        router.prepare(for: segue)
    }
    
    
    func selected(row: Int) {
        let match = searchMatches[row]
        if match.mbid != nil {
            router.selected(match)
        }
    }
    
    
    func numberOfSearchMathes() -> Int {
        return searchMatches.count
    }
    
    func match(forRow: Int) -> SearchMatches {
        return searchMatches[forRow]
    }
    
    
    func setSearchCondition(_ condition: Int) {
        if let condition = SearchCondition(rawValue: condition) {
            searchCondition = condition
        }
    }
    
    func viewIsReady() {
        
    }
    
    func scopeBarPresent() -> Bool {
        return true
    }
    
    func scopeBarTitles() -> [String] {
        return ["Artist","Song","Album"]
    }
    
    func selectedScopeBarTitle() -> SearchCondition {
        return searchCondition
    }
    
    func searchFailed(error: Error?) {
        DispatchQueue.main.async {
            self.view.stopActivityIndicator()
            if let errorMsg = error?.localizedDescription {
                self.view.showError(errorMsg)
            } else {
                self.view.showError(NSLocalizedString("Unknown error", comment: ""))
            }
            
        }
    }
    
    func clearSearchResults() {
        searchMatches.removeAll()
        self.view.reload()
    }
    
}
extension SearchPresenter : SearchInteractorOutput {
    
    func image(forRow:Int, completion: @escaping (UIImage) -> Void) {
        self.interactor.image(for: searchMatches[forRow]) { (image) in
            DispatchQueue.main.async {
                completion(image)
            }
        }

    }
    
    
    func search(term: String) {
        view.startActivityIndicator()
        interactor.search(condition: searchCondition, artist: term)
    }
    
    func list(results artists: [SearchMatches]) {
        searchMatches = artists
        DispatchQueue.main.async {
            if self.searchMatches.count == 0 {
                self.searchFailed(error: NSError(domain: "No results found", code: (Int.max - 1) , userInfo: [NSLocalizedDescriptionKey : "No results found"]) )
            } else {
                self.view.stopActivityIndicator()
                self.view.reload()
            }

        }
    }
}
