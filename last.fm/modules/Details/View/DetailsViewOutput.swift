//
//  DetailsDetailsViewOutput.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

protocol DetailsViewOutput {

    /**
        @author Dmytro Golub
        Notify presenter that view is ready
    */

    func viewIsReady()
    func title() -> String
}
