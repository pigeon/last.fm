//
//  DetailsDetailsInteractorOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit

protocol DetailsInteractorOutput: class {
    func info(_:MatchInfo)
    func image(_:UIImage)
}
