//
//  CollectionReusableView.swift
//  grainProtectors
//
//  Created by GIRA on 04/02/22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    var heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "blank-profile")
        imageView.clipsToBounds = true
        return imageView
    }()
    var nameLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = ""
        labelView.textAlignment = .center
        return labelView
    }()
    static let identifier = "CollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews(){
//        contentView.addSubview(<#T##UIView#>)
        addSubview(heroImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //addSubviews()
    }
    
       
}
