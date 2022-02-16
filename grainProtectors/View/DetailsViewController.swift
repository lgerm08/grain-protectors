//
//  DetailsViewController.swift
//  grainProtectors
//
//  Created by GIRA on 28/01/22.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var heroImageView: UIImageView!
//
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var cityLabel: UILabel!
//
//    @IBOutlet weak var alignmentLabel: UILabel!
//    @IBOutlet weak var companyLabel: UILabel!
//    @IBOutlet weak var titlePowerStatsLabel: UILabel!
    
    
    private var collectionView: UICollectionView?
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "power")
        return imageView
    }()
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "teste"
        label.textColor = .white
        return label
    }()
//    lazy var contentView: UIView = {
//        let contentView = UIView(frame: .zero)
//        contentView.backgroundColor = .blue
//        contentView.isUserInteractionEnabled = true
//        return contentView
//    }()
    var hero: HeroModel?
    var powerStats: [String] = []
    var powerStatsLabel = ["Intelligence: ", "Strength: ", "Speed: ", "Durability: ", "Power: ", "Combat: "]
    var herosResultsList: [HeroModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 3
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView!.register(AttributeViewCell.self, forCellWithReuseIdentifier: AttributeViewCell.identifier)
        collectionView!.register(HeaderViewCell.self, forCellWithReuseIdentifier: HeaderViewCell.identifier)
//        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView!.register(CollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: CollectionReusableView.identifier)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        addSubviews()
//        setupConstraints()
        //Collection View Preparation

//        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "powerStatsCell")
//
//        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        let powerStatsData = [hero?.powerStats?.intelligence, hero?.powerStats?.strength, hero?.powerStats?.speed, hero?.powerStats?.durability, hero?.powerStats?.power, hero?.powerStats?.combat]
        var aux = 0
        for (index, powerStat) in powerStatsData.enumerated(){
            if powerStat == "null"{
                powerStatsLabel.remove(at: index-aux)
                aux += 1
            } else{
                powerStats.append(powerStat!)
            }
        }
    }
    func addSubviews(){
        view.addSubview(collectionView!)
        setupConstrains()
    }
    func setupConstrains(){
        collectionView!.frame = view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView!.frame = view.bounds
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return powerStatsLabel.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let header = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.identifier, for: indexPath) as! HeaderViewCell
            header.nameLabel.text = hero?.name
            header.companyLabel.text = "Company: " + hero!.publisher
            
            if hero?.city == "-"{
                header.cityLabel.text = "Place of Birth: Unknown"
            } else{
                header.cityLabel.text = "From: " + (hero?.city)!
            }
            header.heroImage.sd_setImage(with: URL(string: hero!.image), placeholderImage: UIImage(named: hero!.name))
            header.heroImage.layer.masksToBounds = false
            header.heroImage.layer.cornerRadius = 10
            header.heroImage.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            header.heroImage.clipsToBounds = true
            if powerStatsLabel.isEmpty {
                header.powerStatsLabel.text = "No powerstats available"
                header.powerStatsLabel.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)
            } else{
                header.powerStatsLabel.text = "Power Stats"
                // header.powerStatsLabel.layer.opacity = 0.0
            }
            
            return header
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttributeViewCell.identifier, for: indexPath) as! AttributeViewCell
            switch powerStatsLabel[indexPath.row-1]{
            case "Intelligence: ":
                cell.attributeImage.image = UIImage(named: "intelligence")
            case "Strength: ":
                cell.attributeImage.image = UIImage(named: "strength")
            case "Speed: ":
                cell.attributeImage.image = UIImage(named: "speed")
            case "Durability: ":
                cell.attributeImage.image = UIImage(named: "durability")
            case "Power: ":
                cell.attributeImage.image = UIImage(named: "power")
            case "Combat: ":
                cell.attributeImage.image = UIImage(named: "combat")
            default:
                cell.attributeImage.image = UIImage(named: "default")
            }
            cell.attributeLabel.text = powerStatsLabel[indexPath.row-1] + "\n" + powerStats[indexPath.row-1]
            cell.attributeImage.layer.borderWidth = 1.0
            cell.attributeImage.layer.masksToBounds = false
            cell.attributeImage.layer.cornerRadius = 0.05*cell.attributeImage.image!.size.width/2
            cell.attributeImage.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            cell.attributeImage.clipsToBounds = true
            
            return cell
        }
        
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if indexPath.row == 0 {
                return CGSize(width: view.frame.size.width, height: 380)
            } else {
                return CGSize(width: 120, height: 180)
            }
            
            
    }
    
}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
