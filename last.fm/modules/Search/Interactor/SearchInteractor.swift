//
//  SearchSearchInteractor.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit

class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput!
    var api:SearchArtist?

    func search(condition searchCondition:SearchCondition,artist: String) {
        guard let api = api else {
            let error = NSError(domain: "API handler init has failed", code: Int.max-2, userInfo: [NSLocalizedDescriptionKey:"API handler init has failed"])
            self.output.searchFailed(error:error)
            return
        }
        
        api.search(mode: searchCondition, artist: artist) {  [weak self] matches, error in
            if matches.count > 0 && error == nil {
                self?.output.list(results: matches)
            } else {
                self?.output.searchFailed(error: error)
            }
        }
    }

    
    func image(for match: SearchMatches, completion: @escaping (UIImage) -> Void) {
        guard let strURL = match.imageURL, let url = URL(string: strURL) else {
            return
        }
        
        MTAPIClient.downloadImage(url: url) { (image, error) in
            guard let image = image else {
                return
            }
            completion(image)
        }
    }

    func setApiHandler(_ searchApi: SearchArtist) {
        api = searchApi
    }

}
