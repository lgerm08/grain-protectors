//
//  ViewController.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import UIKit

class HeroViewController: UIViewController {
    
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var heroManager = HeroManager()
    var heroSearchManager = HeroSearchManager()
    var herosResultsList: [HeroModel] = []
    var heroDetails : HeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroSearchManager.delegate = self
        heroManager.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
        //searchBar.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let randomId = Int.random(in: 1...100)
        heroManager.fetchHeroById(heroId: String(randomId))
        //heroSearchManager.findHero(searchBar.text!.lowercased())
        
    }
    
    
}


//MARK: - HeroManagerDelegate

extension HeroViewController : HeroManagerDelegate {
    func didUpdateButton(_ HeroManager: HeroManager, hero: HeroModel) {
        DispatchQueue.main.async {
//            self.selectedHeroName = hero.name
//            self.selectedHeroCity = hero.city ?? "empty"
//            self.selectedHeroAlignemt = hero.alignment
//            self.selectedHeroCompany = hero.publisher
//            self.selectedHeroUrlImage = hero.image
//            self.selectedHeroIntelligence = hero.powerStats!.intelligence
//            self.selectedHeroStrength = hero.powerStats?.strength ?? nil
//            self.selectedHeroSpeed = hero.powerStats?.speed ?? nil
//            self.selectedHeroDurability = hero.powerStats?.durability ?? nil
//            self.selectedHeroPower = hero.powerStats?.power ?? nil
//            self.selectedHeroCombat = hero.powerStats?.combat ?? nil
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                    viewController.hero = hero
                    self.present(viewController, animated: true, completion: nil)
                }
        }
        
    }
    func failedWithError(error: Error) {
        print(error)
    }
}

//MARK: - HeroSearchDelegate

extension HeroViewController : HeroSearchDelegate {
    func didUpdateSearch(_ HeroManager: HeroSearchManager, heros: HeroSearchDataModel) {
        
        DispatchQueue.main.async {
            self.herosResultsList = []
            for hero in heros.results{
                let newHero = HeroModel(name: hero.name, id: hero.id, image: hero.image.url, alignment: hero.biography.alignment, publisher: hero.biography.publisher, city: hero.biography.city, powerStats: PowerStats(intelligence: hero.powerstats.intelligence, strength: hero.powerstats.strength, speed: hero.powerstats.speed, durability: hero.powerstats.durability, power: hero.powerstats.power, combat: hero.powerstats.combat))
                //print(newHero.id!)
                self.herosResultsList.append(newHero)
            }
            self.herosResultsList = self.herosResultsList.sorted{
                $0.city! < $1.city!
            }
            self.resultsTableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No matches were found", message: "The hero you are looking for is not a grain protector", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { Action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


//MARK: - Search Bar Methods
extension HeroViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       // print("text did begin editing")
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // print("search pressed")
        if searchBar.text?.count != 0{
            heroSearchManager.findHero(searchBar.text!.lowercased())
            resultsTableView.reloadData()
        }
        //print("if statement failed")
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("change detected")
        if searchBar.text?.count == 0 {
            //loadItems()
            herosResultsList = []
            resultsTableView.reloadData()

        }else if searchBar.text!.count >= 3{
            heroSearchManager.findHero(searchBar.text!.lowercased())
        }
        
        
    }
}

//MARK: - TableView DataSource

extension HeroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return herosResultsList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroCell
        //let url = URL(string: "https://www.superherodb.com/pictures2/portraits/10/100/638.jpg")
        let imageUrl = URL(string: herosResultsList[indexPath.row].image)
         
      //  DispatchQueue.global().async { [weak self] in
        DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.heroImageView.image = image
                            }
                        }
                    }
                }
        
        cell.fullNameLabel.text = "Name: " + herosResultsList[indexPath.row].name
        cell.cityLabel.text = "From: " + herosResultsList[indexPath.row].city!
        cell.companyLabel.text = "Company: " + herosResultsList[indexPath.row].publisher
        //cell.textLabel?.text = herosResultsList[indexPath.row].name
        
        return cell
        
    }
}

//MARK: - TableView Delegate

extension HeroViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "goToHero", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                viewController.hero = herosResultsList[indexPath.row]
                self.present(viewController, animated: true, completion: nil)
            }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("segue prepared")
//        if segue.identifier == "goToHero"{
//            let destinationVC = segue.destination as! DetailsViewController
//            destinationVC.name = selectedHeroName
//            destinationVC.city = selectedHeroCity
//            destinationVC.alignment = selectedHeroAlignemt
//            destinationVC.company = selectedHeroCompany
//            destinationVC.urlImage = selectedHeroUrlImage
//            destinationVC.intelligence = selectedHeroIntelligence
//            destinationVC.strength = selectedHeroStrength
//            destinationVC.speed = selectedHeroSpeed
//            destinationVC.durability = selectedHeroDurability
//            destinationVC.power = selectedHeroPower
//            destinationVC.combat = selectedHeroCombat
//            print(selectedHeroName)
//        }
//    }
    
    
}



