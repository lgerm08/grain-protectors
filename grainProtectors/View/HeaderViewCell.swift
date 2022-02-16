
import UIKit

class HeaderViewCell: UICollectionViewCell {

    static var identifier = "HeaderViewCell"
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
        labelView.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
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
    var powerStatsLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = ""
        labelView.textAlignment = .center
        labelView.numberOfLines = 0
        return labelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        contentView.clipsToBounds = true
    }
    
    func addSubviews(){
        contentView.addSubview(heroImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(powerStatsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //heroImage.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: 100)
        //nameLabel.frame = CGRect(x: 5, y: 110, width: contentView.frame.size.width-10, height: 50)
        heroImage.anchor(top: contentView.topAnchor, centerX: contentView.centerXAnchor, topConstant: 20, widthConstant: 200, heightConstant: 200)
        nameLabel.anchor(top: heroImage.bottomAnchor,  centerX: contentView.centerXAnchor, topConstant: 8, heightConstant: 35)
        cityLabel.anchor(top: nameLabel.bottomAnchor,  centerX: contentView.centerXAnchor, topConstant: 8, heightConstant: 25)
        companyLabel.anchor(top: cityLabel.bottomAnchor,  centerX: contentView.centerXAnchor, topConstant: 8, heightConstant: 25)
        powerStatsLabel.anchor(top: companyLabel.bottomAnchor,  centerX: contentView.centerXAnchor, topConstant: 15, heightConstant: 25)
    }
    
}
