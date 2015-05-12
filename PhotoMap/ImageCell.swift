//
//  ImageCell.swift
//  PhotoMap
//
//  Created by 平屋真吾 on 2015/05/09.
//  Copyright (c) 2015年 Shingo Hiraya. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet private weak var assetImageView: UIImageView!
    
    var assetImage :UIImage? {
        willSet {
            self.assetImageView.image = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
