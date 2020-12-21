//
//  SearchCell.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//   Dmytro Golub. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setSearchResult(_ result:SearchMatches) {
        self.textLabel?.text = result.albumName
        self.detailTextLabel?.text = result.artist
        self.imageView?.image = UIImage(named: "placeholder")
        self.accessoryType = (result.mbid == nil) ?.none : .disclosureIndicator
    }

}
