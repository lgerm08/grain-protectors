//
//  HeroCell.swift
//  grainProtectors
//
//  Created by GIRA on 28/01/22.
//

import UIKit

class HeroCell: UITableViewCell {

    static var identifier = "HeroCell"
    
    var heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "power")
        imageView.clipsToBounds = true
        return imageView
    }()
    var nameLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = ""
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        return labelView
    }()
    var cityLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = ""
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        return labelView
    }()
    var companyLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = ""
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        return labelView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubviews()
    }
    func addSubviews(){
        print("add subview called")
        contentView.addSubview(heroImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(companyLabel)
        setConstraints()
    }
    func setConstraints(){
        print("layout subviews called")
        heroImage.anchor(left: contentView.leftAnchor, centerY: contentView.centerYAnchor, leftConstant: 15, widthConstant: 130, heightConstant: 130)
        nameLabel.anchor(top: contentView.topAnchor, left: heroImage.rightAnchor, topConstant: 25, leftConstant: 10 ,widthConstant: 220, heightConstant: 25)
        cityLabel.anchor(top: nameLabel.topAnchor, left: heroImage.rightAnchor, topConstant: 25, leftConstant: 10 ,widthConstant: 220, heightConstant: 25)
        companyLabel.anchor(top: cityLabel.topAnchor, left: heroImage.rightAnchor, topConstant: 25, leftConstant: 10 ,widthConstant: 220, heightConstant: 25)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


    
    
    
  
