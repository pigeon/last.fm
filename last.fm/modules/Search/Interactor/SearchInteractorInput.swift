//
//  SearchSearchInteractorInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit

protocol SearchInteractorInput {
    
    func setApiHandler(_: SearchArtist) 
    func search(condition searchCondition:SearchCondition,artist:String)
    func image(for match:SearchMatches,completion:@escaping (UIImage)->Void)
}
