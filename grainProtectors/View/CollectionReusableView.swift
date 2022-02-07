//
//  CollectionReusableView.swift
//  grainProtectors
//
//  Created by GIRA on 04/02/22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {


    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var powerStatsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
