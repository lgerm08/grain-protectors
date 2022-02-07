//
//  DetailsViewController.swift
//  grainProtectors
//
//  Created by GIRA on 28/01/22.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titlePowerStatsLabel: UILabel!
    
    var hero: HeroModel?
    var powerStats: [String] = []
    var powerStatsLabel = ["Intelligence: ", "Strength: ", "Speed: ", "Durability: ", "Power: ", "Combat: "]
    var herosResultsList: [HeroModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Collection View Preparation
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "powerStatsCell")
        
        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        let powerStatsData = [hero?.powerStats?.intelligence, hero?.powerStats?.strength, hero?.powerStats?.speed, hero?.powerStats?.durability, hero?.powerStats?.power, hero?.powerStats?.combat]
        var aux = 0
        for (index, powerStat) in powerStatsData.enumerated(){
            if powerStat == "null"{
                powerStatsLabel.remove(at: index-aux)
                //print("null powerstat")
                aux += 1
            } else{
                powerStats.append(powerStat!)
            }
        }
    }
}

//MARK: - Collection View Data Source

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return powerStats.count
        //return 1
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"powerStatsCell" , for: indexPath) as! DetailsCollectionViewCell
        
        switch powerStatsLabel[indexPath.row]{
        case "Intelligence: ":
            cell.attributeImageView.image = UIImage(named: "intelligence")
        case "Strength: ":
            cell.attributeImageView.image = UIImage(named: "strength")
        case "Speed: ":
            cell.attributeImageView.image = UIImage(named: "speed")
        case "Durability: ":
            cell.attributeImageView.image = UIImage(named: "durability")
        case "Power: ":
            cell.attributeImageView.image = UIImage(named: "power")
        case "Combat: ":
            cell.attributeImageView.image = UIImage(named: "combat")
        default:
            cell.attributeImageView.image = UIImage(named: "default")
        }
        cell.attributeLabel.text = powerStatsLabel[indexPath.row]
        cell.valueLabel.text = powerStats[indexPath.row]
        cell.attributeImageView.layer.borderWidth = 1.0
        cell.attributeImageView.layer.masksToBounds = false
        cell.attributeImageView.layer.cornerRadius = 0.05*cell.attributeImageView.image!.size.width/2
        cell.attributeImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.attributeImageView.clipsToBounds = true
        return cell
    }
    
}
    //MARK: - Collection Header
extension DetailsViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CollectionReusableView
        header.nameLabel.text = hero?.name
        header.companyLabel.text = "Company: " + hero!.publisher
        
        if hero?.city == "-"{
            header.cityLabel.text = "Place of Birth: Unknown"
        } else{
            header.cityLabel.text = "From: " + (hero?.city)!
        }
        header.heroImage.sd_setImage(with: URL(string: hero!.image), placeholderImage: UIImage(named: hero!.name))
        if powerStatsLabel.isEmpty {
            header.powerStatsLabel.text = "No powerstats available"
        } else{
           header.powerStatsLabel.text = "Power Stats"
           // header.powerStatsLabel.layer.opacity = 0.0
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 380)
    }
}




