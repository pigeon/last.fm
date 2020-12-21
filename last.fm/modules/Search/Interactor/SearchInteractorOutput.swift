//
//  SearchSearchInteractorOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit


protocol SearchInteractorOutput: class {
    func list(results:[SearchMatches])
    func searchFailed(error:Error?)
}
