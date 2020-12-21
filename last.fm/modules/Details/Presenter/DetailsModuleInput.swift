//
//  DetailsDetailsModuleInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

protocol DetailsModuleInput: class {
    func setDetails(_:SearchMatches)
    func setSearchDetailsApiHandler(_ api: SearchInfo)
}
