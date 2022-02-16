
import UIKit

class AttributeViewCell: UICollectionViewCell {

    static var identifier = "AttributeViewCell"
    var attributeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "power")
        imageView.clipsToBounds = true
        return imageView
    }()
    var attributeLabel: UILabel = {
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
        contentView.addSubview(attributeImage)
        contentView.addSubview(attributeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        attributeImage.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: 100)
        attributeLabel.frame = CGRect(x: 5, y: 110, width: contentView.frame.size.width-10, height: 50)
    }
    
}
