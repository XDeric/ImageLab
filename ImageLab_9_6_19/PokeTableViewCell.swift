//
//  PokeTableViewCell.swift
//  ImageLab_9_6_19
//
//  Created by EricM on 9/9/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    @IBOutlet weak var pokeCardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
