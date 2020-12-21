//
//  SearchSearchRouterInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit

protocol SearchRouterInput {
    func selected(_:SearchMatches)
    func prepare(for segue: UIStoryboardSegue)
    func setSearchDetailsApiHandler(_ api: SearchInfo)
}
