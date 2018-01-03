//
//  DetailsDetailsInteractor.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation

class DetailsInteractor: DetailsInteractorInput {

    
    weak var output: DetailsInteractorOutput!
    var searchInfo:SearchInfo?  //LastFM_API("3812d751380a11228e55d28e67c4a01f", secret: "")

    func setSearchDetailsApiHandler(_ api: SearchInfo) {
        searchInfo = api
     }
    
    
    func getInfo(_ match: SearchMatches) {
        if let api = searchInfo {
            api.info(match: match) { [weak self] info,error in
                if let info = info {
                    self?.output.info(info)
                    self?.image(for: info.imageURL)
                }
            }
        }
    }
    
    func image(for strURL: String?) {
        guard let strURL = strURL, let url = URL(string: strURL) else {
            return
        }
        
        MTAPIClient.downloadImage(url: url) { (image, error) in
            guard let image = image else {
                return
            }
            self.output.image(image)
        }
    }
    
    
}
