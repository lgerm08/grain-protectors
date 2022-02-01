import Foundation

protocol HeroManagerDelegate{
    func didUpdateButton(_ HeroManager: HeroManager, hero: HeroModel)
    func failedWithError(error: Error)
}


protocol LoadHeroData{
    func heroSelected(_ heroId: HeroModel )
}
struct HeroManager {
    
    let heroIdURL = "https://superheroapi.com/api/6818915951517062"
    let findHeroURL = "https://superheroapi.com/api/6818915951517062/search"
    
    var delegate: HeroManagerDelegate?
    
    func fetchHeroById(heroId: String){
        let urlString = "\(heroIdURL)/\(heroId)"
        //print(urlString)
        performRequest(with: urlString)
    }

    
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.failedWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let hero = parseJSON(safeData){
                        print("safe data from json checked")
                        self.delegate?.didUpdateButton(self, hero: hero)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ heroData: Data) -> HeroModel?{
        let decoder = JSONDecoder()
        print("parseJSON called")
        do{
            let decodedData = try decoder.decode(HeroData.self, from:  heroData)
            let powerStats = PowerStats(intelligence: decodedData.powerstats.intelligence, strength: decodedData.powerstats.strength, speed: decodedData.powerstats.speed, durability: decodedData.powerstats.durability, power: decodedData.powerstats.power, combat: decodedData.powerstats.combat)
            let hero = HeroModel(name: decodedData.name, id: nil, image: decodedData.image.url, alignment: decodedData.biography.alignment, publisher: decodedData.biography.publisher, city: decodedData.biography.city, powerStats: powerStats)
//
            print(hero.name)
            
            return hero
            
                  
        } catch{
            delegate?.failedWithError(error: error)
            return nil
        }
        
    }
    
}
