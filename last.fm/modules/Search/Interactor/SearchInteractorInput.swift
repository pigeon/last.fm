//
//  SearchSearchInteractorInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import Foundation
import UIKit

protocol SearchInteractorInput {
    
    func setApiHandler(_: SearchArtist) 
    func search(condition searchCondition:SearchCondition,artist:String)
    func image(for match:SearchMatches,completion:@escaping (UIImage)->Void)
}
