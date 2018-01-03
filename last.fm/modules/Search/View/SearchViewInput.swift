//
//  SearchSearchViewInput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

protocol SearchViewInput: class {

    func startActivityIndicator()
    func stopActivityIndicator()
    
    func reload()
    func showError(_ errorMsg:String)
}
