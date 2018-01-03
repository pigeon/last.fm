//
//  SearchSearchRouterInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRouterInput {
    func selected(_:SearchMatches)
    func prepare(for segue: UIStoryboardSegue)
    func setSearchDetailsApiHandler(_ api: SearchInfo)
}
