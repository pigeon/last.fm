//
//  DetailsDetailsModuleInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

protocol DetailsModuleInput: class {
    func setDetails(_:SearchMatches)
    func setSearchDetailsApiHandler(_ api: SearchInfo)
}
