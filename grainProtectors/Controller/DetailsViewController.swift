//
//  DetailsViewController.swift
//  grainProtectors
//
//  Created by GIRA on 28/01/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titlePowerStatsLabel: UILabel!
    
    var hero: HeroModel?
    var urlImage: String = ""
    var name: String = ""
    var city: String = ""
    var alignment: String = ""
    var company: String = ""
    var intelligence: String? = ""
    var strength: String? = ""
    var speed: String? = ""
    var durability: String? = ""
    var power: String? = ""
    var combat: String? = ""
    var powerStats: [String] = []
    var powerStatsLabel = ["Intelligence: ", "Strength: ", "Speed: ", "Durability: ", "Power: ", "Combat: "]
    var herosResultsList: [HeroModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "powerStatsCell")
        nameLabel.text = "Name: " + hero!.name
        if hero?.city == "-"{
            cityLabel.text = "Place of Birth: Unknown"
        } else{
            cityLabel.text = "City: " + (hero?.city)!
        }
        alignmentLabel.text = "Alignment: " + hero!.alignment
        companyLabel.text = "Company: " + hero!.publisher
        DispatchQueue.global().async { [weak self] in
            if let imageUrl = URL(string: self?.hero?.image ?? ""){
                if let data = try? Data(contentsOf: imageUrl) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.heroImageView.image = image
                                }
                            }
                        }
                    }
            }
            
        let powerStatsData = [hero?.powerStats?.intelligence, hero?.powerStats?.strength, hero?.powerStats?.speed, hero?.powerStats?.durability, hero?.powerStats?.power, hero?.powerStats?.combat]
        var aux = 0
        for (index, powerStat) in powerStatsData.enumerated(){
            if powerStat == "null"{
                powerStatsLabel.remove(at: index-aux)
                //print("null powerstat")
                aux += 1
            } else{
                powerStats.append(powerStat!)
                //print(powerStat!)
            }
        }
        print(powerStatsLabel.count)
        if powerStatsLabel.isEmpty {
            titlePowerStatsLabel.text = "No powerstats registered for this character"
        }
        //print(powerStats.count)
    }


}


extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return powerStats.count
        //return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"powerStatsCell" , for: indexPath) as! DetailsCollectionViewCell
        cell.attributeLabel.text = powerStatsLabel[indexPath.row]
        cell.valueLabel.text = powerStats[indexPath.row]
        //cell.heroImageView.image = UIImage(contentsOfFile: "inteligence.png")
        //print(powerStatsLabel[indexPath.row])
        
        return cell
    }
    
}
