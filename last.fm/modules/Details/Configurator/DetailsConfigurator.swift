//
//  DetailsDetailsConfigurator.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
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
