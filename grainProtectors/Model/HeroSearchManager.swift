import Foundation

protocol HeroSearchDelegate{
    func didUpdateSearch(_ HeroManager: HeroSearchManager, heros: HeroSearchDataModel)
    func didFailWithError(error: Error)
}

struct HeroSearchManager {
    
    let findHeroURL = "https://superheroapi.com/api/6818915951517062/search"
    
    var delegate: HeroSearchDelegate?
    
    func findHero(_ heroName : String){
        let urlString = "\(findHeroURL)/\(heroName)"
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let heroList = parseJSON(safeData){
                        self.delegate?.didUpdateSearch(self, heros: heroList)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ heroList: Data) -> HeroSearchDataModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(HeroSearchDataModel.self, from:  heroList)
            //print(decodedData.results[2].name)
            let searchResults = decodedData
            //let alignment = decodedData.biography.alignment
            
            //let hero = HeroModel(name: name, alignment: alignment)
            //let heroList = HeroModel(name: name)
            
            //print(searchResults.results[3].name)
            //print(hero.alignment)
            
            return searchResults
            
                  
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
