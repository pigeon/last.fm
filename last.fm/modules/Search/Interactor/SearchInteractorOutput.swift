//
//  SearchSearchInteractorOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation
import UIKit


protocol SearchInteractorOutput: class {
    func list(results:[SearchMatches])
    func searchFailed(error:Error?)
}
