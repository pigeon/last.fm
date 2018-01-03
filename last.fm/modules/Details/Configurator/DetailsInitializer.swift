//
//  DetailsDetailsInitializer.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

class DetailsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var detailsViewController: DetailsViewController!

    override func awakeFromNib() {

        let configurator = DetailsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: detailsViewController)
    }

}
