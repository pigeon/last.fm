//
//  DetailsDetailsViewInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

protocol DetailsViewInput: class {

    /**
        @author Dmytro Golub
        Setup initial state of the view
    */

    func setupInitialState()
    func setInfo(_:MatchInfo)
    func setInfoImage(_:UIImage)
}
