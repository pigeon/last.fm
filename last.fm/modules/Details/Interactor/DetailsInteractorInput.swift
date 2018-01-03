//
//  DetailsDetailsInteractorInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {
    func getInfo(_ match:SearchMatches)
     func setSearchDetailsApiHandler(_ api: SearchInfo)
}
