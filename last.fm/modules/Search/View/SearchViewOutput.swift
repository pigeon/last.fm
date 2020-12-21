//
//  SearchSearchViewOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import UIKit

protocol SearchViewOutput {

    /**
        @author Dmytro Golub
        Notify presenter that view is ready
    */

    func viewIsReady()
    func scopeBarPresent() -> Bool
    func scopeBarTitles() -> [String]
    func selectedScopeBarTitle() -> SearchCondition
    func search(term:String)
    func setSearchCondition(_ condition:Int)
    
    func numberOfSearchMathes() -> Int
    func match(forRow:Int) -> SearchMatches
    
    func image(forRow: Int, completion: @escaping (UIImage)->Void)
    func clearSearchResults()

    func selected(row:Int)
    func prepare(for segue: UIStoryboardSegue)
    
}
