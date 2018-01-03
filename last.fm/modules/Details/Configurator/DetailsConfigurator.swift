//
//  DetailsDetailsConfigurator.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

class DetailsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? DetailsViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: DetailsViewController) {


        let presenter = DetailsPresenter()
        presenter.view = viewController

        let interactor = DetailsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
