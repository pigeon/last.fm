//
//  DetailsDetailsPresenter.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import Foundation
import UIKit

class DetailsPresenter {
    
    weak var view: DetailsViewInput!
    var interactor: DetailsInteractorInput!
    var selectedSeatch:SearchMatches?

    func viewIsReady() {

    }
    
}

extension DetailsPresenter : DetailsInteractorOutput {
    func image(_ image: UIImage) {
        DispatchQueue.main.async {
            self.view.setInfoImage(image)
        }
    }
    
    func info(_ info: MatchInfo) {
        DispatchQueue.main.async {
            self.view.setInfo(info)
        }
    }
}

extension DetailsPresenter : DetailsViewOutput {
    func title() -> String {
        guard let title = selectedSeatch?.albumName else {
            return ""
        }
        return title
    }
}

extension DetailsPresenter:DetailsModuleInput {
    func setSearchDetailsApiHandler(_ api: SearchInfo) {
        self.interactor.setSearchDetailsApiHandler(api)
    }
    
    func setDetails(_ match: SearchMatches) {
        selectedSeatch = match
        interactor.getInfo(match)
    }

}
