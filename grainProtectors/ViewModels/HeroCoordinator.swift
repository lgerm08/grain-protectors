//
//  HeroCoordinator.swift
//  grainProtectors
//
//  Created by GIRA on 11/02/22.
//

import UIKit
 
class HeroCoordinator {
    
    func goToDetails(hero: HeroModel, currentViewController: HeroViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                viewController.hero = hero
                currentViewController.present(viewController, animated: true, completion: nil)
            }
    }
}
