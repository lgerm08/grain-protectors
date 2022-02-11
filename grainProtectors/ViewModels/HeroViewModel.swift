//
//  ViewController.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import UIKit
import SDWebImage

protocol HeroViewModelProtocol{
    func didSearchRandom(hero: HeroModel)
    func didSearch(heros: HeroSearchDataModel)
    func searchDidFail(error:Error)
}


class HeroViewModel {
    
    var heroManager = HeroService()
    var heroProtocol: HeroViewModelProtocol?
    var searchService = SearchService()
    
    func randomHero(id:Int){
        heroManager.delegate = self
        heroManager.fetchHeroById(heroId: String(id))
    }
    func searchHero(heroName: String){
        searchService.delegate = self
        searchService.findHero(heroName)
    }
    
    
}

extension HeroViewModel: HeroServiceDelegate {
    
    func didPressedRandom(_ HeroService: HeroService, hero: HeroModel) {
        heroProtocol?.didSearchRandom(hero: hero)
    }
    func failedWithError(error: Error) {
        print("Erro ao capturar")
        print(error)
    }
    
}

extension HeroViewModel: HeroSearchDelegate{
    func didUpdateSearch(_ HeroManager: SearchService, heros: HeroSearchDataModel) {
        heroProtocol?.didSearch(heros: heros)
    }
    
    func didFailWithError(error: Error) {
        heroProtocol?.searchDidFail(error: error)
    }
    
    
}
