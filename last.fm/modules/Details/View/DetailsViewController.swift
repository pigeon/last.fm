//
//  DetailsDetailsViewController.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import UIKit

class DetailsViewController: UIViewController {
    

    var output: DetailsViewOutput!

    // MARK: Life cycle
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = output.title()
        output.viewIsReady()
    }


    // MARK: DetailsViewInput
    func setupInitialState() {
    }
    
    
}

extension DetailsViewController : DetailsViewInput {
    func setInfoImage(_ image: UIImage) {
        self.image.image = image
    }
    
    
    func setInfo(_ info: MatchInfo) {
        if let bio = info.info {
            self.info.text = bio
        }
    }
}

