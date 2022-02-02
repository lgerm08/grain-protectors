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
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "powerStatsCell")
        
        //View Elements Preparation
        //nameLabel.text = "Name: " + hero!.name
        nameLabel.text =  hero!.name
        heroImageView.sd_setImage(with: URL(string: hero!.image), placeholderImage: UIImage(named: hero!.name))
        if hero?.city == "-"{
            cityLabel.text = "Place of Birth: Unknown"
        } else{
            cityLabel.text = "City: " + (hero?.city)!
        }
        alignmentLabel.text = "Alignment: " + hero!.alignment
        companyLabel.text = "Company: " + hero!.publisher

        //Filtering non-null hero attributes
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
        if powerStatsLabel.isEmpty {
            titlePowerStatsLabel.text = "No powerstats registered for this character"
        }
    }
}

//MARK: - Collection View Data Source

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return powerStats.count
        //return 1
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
        
        return cell
    }
    
}

