//
//  SearchSearchModuleInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

protocol SearchModuleInput: class {
    func setSearchApiHandler(_:SearchArtist)
    func setSearchDetailsApiHandler(_:SearchInfo)
}
