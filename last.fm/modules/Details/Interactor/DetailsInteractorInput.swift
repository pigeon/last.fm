//
//  DetailsDetailsInteractorInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation

protocol DetailsInteractorInput {
    func getInfo(_ match:SearchMatches)
     func setSearchDetailsApiHandler(_ api: SearchInfo)
}
