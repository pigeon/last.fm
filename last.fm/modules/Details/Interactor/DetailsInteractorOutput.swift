//
//  DetailsDetailsInteractorOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsInteractorOutput: class {
    func info(_:MatchInfo)
    func image(_:UIImage)
}
