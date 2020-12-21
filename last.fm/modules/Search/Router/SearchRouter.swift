//
//  SearchSearchRouter.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import UIKit

class SearchRouter: SearchRouterInput {

    let transitionName = "DetailsViewController"
    
    var match:SearchMatches?
    var transitionViewController:UIViewController?
    var searchInfoApi:SearchInfo?
    
    func setSearchDetailsApiHandler(_ api: SearchInfo) {
        searchInfoApi = api
    }
    
    func selected(_ searchMatch: SearchMatches) {
        match = searchMatch
        transitionViewController?.performSegue(withIdentifier: transitionName, sender: self)
    }
    
    func prepare(for segue: UIStoryboardSegue) {
        guard let detailsVC = segue.destination as? DetailsViewController , let match = match  else {
            return
        }
        
        guard let moduleInput = detailsVC.output as? DetailsModuleInput else {
            return
        }
    
        if let searchInfoApi = searchInfoApi {
            moduleInput.setSearchDetailsApiHandler(searchInfoApi)
            moduleInput.setDetails(match)
        }
        
    }

}
