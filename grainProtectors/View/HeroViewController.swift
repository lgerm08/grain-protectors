//
//  ViewController.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import UIKit
import SDWebImage

class HeroViewController: UIViewController {
    
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "random")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(randomPressed), for: .touchUpInside)
        return button
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Find an Avenger Grain"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        return searchBar
    }()
    private lazy var heroResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    var herosResultsList: [HeroModel] = []
    var heroDetails : HeroModel?
    var viewModel = HeroViewModel()
    var hero : HeroModel?
    var coordinator = HeroCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.heroProtocol = self
        
        heroResultsTableView.dataSource = self
        heroResultsTableView.delegate = self
        heroResultsTableView.register(HeroCell.self, forCellReuseIdentifier: HeroCell.identifier)
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        addSubviews()
        
    }
    func setupConstraints() {
        randomButton.anchor(top: view.topAnchor, right: view.rightAnchor,  topConstant: 50,   rightConstant: 10, widthConstant: 80, heightConstant: 80)
        randomButton.layer.cornerRadius = 40
        randomButton.setImage(UIImage(named: "random"), for: .normal)
        randomButton.clipsToBounds = true
        searchBar.anchor(top: view.topAnchor, left: view.leftAnchor, topConstant: 70, leftConstant: 10, widthConstant: view.frame.width - 105, heightConstant: 40)
        heroResultsTableView.anchor(top: randomButton.bottomAnchor, bottom: view.bottomAnchor, centerX: view.centerXAnchor, topConstant: 10, bottomConstant: 10, widthConstant: view.frame.size.width, heightConstant: view.frame.self.height)
    }
    func addSubviews(){
        view.backgroundColor = .white
        view.addSubview(randomButton)
        view.addSubview(searchBar)
        view.addSubview(heroResultsTableView)
        setupConstraints()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func randomPressed() {
        let randomId = Int.random(in: 1...100)
        viewModel.randomHero(id: randomId)
    }
    

    
}

//MARK: - HeroViewModelProtocols
extension HeroViewController: HeroViewModelProtocol{
    func searchDidFail(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No matches were found", message: "The hero you are looking for is not an Avenger Grain", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { Action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didSearch(heros: HeroSearchDataModel) {
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
            self.heroResultsTableView.reloadData()
        }
    }
    
    func didSearchRandom(hero: HeroModel) {
        DispatchQueue.main.async {
            self.coordinator.goToDetails(hero: hero, currentViewController: self)
        }
    }
}


//MARK: - Search Bar Methods
extension HeroViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            herosResultsList = []
            heroResultsTableView.reloadData()

        }else {
            viewModel.searchHero(heroName: searchBar.text!.lowercased())
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            herosResultsList = []
            heroResultsTableView.reloadData()

        }else if searchBar.text!.count >= 3{
            viewModel.searchHero(heroName: searchBar.text!.lowercased())
        }
    }
}

//MARK: - TableView DataSource

extension HeroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return herosResultsList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroCell
        cell.nameLabel.text = "Name: " + herosResultsList[indexPath.row].name
        cell.heroImage.sd_setImage(with: URL(string: herosResultsList[indexPath.row].image), placeholderImage: UIImage(named: herosResultsList[indexPath.row].name))
        cell.heroImage.layer.masksToBounds = false
        cell.heroImage.layer.cornerRadius = 0.1*130
        cell.heroImage.clipsToBounds = true

        cell.nameLabel.text = "Name: " + herosResultsList[indexPath.row].name
        cell.cityLabel.text = "From: " + herosResultsList[indexPath.row].city
        cell.companyLabel.text = "Company: " + herosResultsList[indexPath.row].publisher
        //cell.textLabel?.text = herosResultsList[indexPath.row].name
        cell.addSubviews()
        return cell
    }
}

//MARK: - TableView Delegate

extension HeroViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator.goToDetails(hero: herosResultsList[indexPath.row], currentViewController: self)
    }
}


