//
//  ViewController.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import UIKit
import SDWebImage

class HeroViewController: UIViewController {
    
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var randomButton: UIButton!
    
    var heroManager = HeroManager()
    var heroSearchManager = HeroSearchManager()
    var herosResultsList: [HeroModel] = []
    var heroDetails : HeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomButton.layer.cornerRadius = 0.5 * randomButton.bounds.size.width
        randomButton.clipsToBounds = true
        heroSearchManager.delegate = self
        heroManager.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
        searchBar.delegate = self
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let randomId = Int.random(in: 1...100)
        heroManager.fetchHeroById(heroId: String(randomId))
    }

    
}


//MARK: - Random Search with HeroManagerDelegate

extension HeroViewController : HeroManagerDelegate {
    func didUpdateButton(_ HeroManager: HeroManager, hero: HeroModel) {
        DispatchQueue.main.async {
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

//MARK: - Custom Search with HeroSearchDelegate

extension HeroViewController : HeroSearchDelegate {
    func didUpdateSearch(_ HeroManager: HeroSearchManager, heros: HeroSearchDataModel) {
        DispatchQueue.main.async {
            self.herosResultsList = []
            for hero in heros.results{
                var placeOfBirth = "Unknown"
                if hero.biography.city != "-"{
                    placeOfBirth = hero.biography.city
                }
                let newHero = HeroModel(name: hero.name, id: hero.id, image: hero.image.url, alignment: hero.biography.alignment, publisher: hero.biography.publisher, city: placeOfBirth, powerStats: PowerStats(intelligence: hero.powerstats.intelligence, strength: hero.powerstats.strength, speed: hero.powerstats.speed, durability: hero.powerstats.durability, power: hero.powerstats.power, combat: hero.powerstats.combat))
                //print(newHero.id!)
                self.herosResultsList.append(newHero)
            }
            self.herosResultsList = self.herosResultsList.sorted{
                $0.city < $1.city
            }
            self.resultsTableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No matches were found", message: "The hero you are looking for is not an Avenger Grain", preferredStyle: .alert)
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            //loadItems()
            herosResultsList = []
            //searchBar.resignFirstResponder()
            resultsTableView.reloadData()

        }else {
            heroSearchManager.findHero(searchBar.text!.lowercased())
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("change detected")
        if searchBar.text?.count == 0 {
            //loadItems()
            herosResultsList = []
            //searchBar.resignFirstResponder()
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
        cell.heroImageView.sd_setImage(with: URL(string: herosResultsList[indexPath.row].image), placeholderImage: UIImage(named: herosResultsList[indexPath.row].name))
        cell.heroImageView.layer.borderWidth = 1.0
        cell.heroImageView.layer.masksToBounds = false
        cell.heroImageView.layer.cornerRadius = 20
        cell.heroImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.heroImageView.clipsToBounds = true
        
        cell.fullNameLabel.text = "Name: " + herosResultsList[indexPath.row].name
        cell.cityLabel.text = "From: " + herosResultsList[indexPath.row].city
        cell.companyLabel.text = "Company: " + herosResultsList[indexPath.row].publisher
        //cell.textLabel?.text = herosResultsList[indexPath.row].name
        
        return cell
    }
}

//MARK: - TableView Delegate

extension HeroViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                viewController.hero = herosResultsList[indexPath.row]
                self.present(viewController, animated: true, completion: nil)
            }
    }
}


