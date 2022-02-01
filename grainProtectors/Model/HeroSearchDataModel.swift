//
//  HeroSearchDataModel.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import Foundation

struct HeroSearchDataModel : Codable{
    let results : [results]
}

struct results : Codable{
    let id : String
    let name : String
    let biography: Biography
    let image: Image
    let powerstats: PowerStats
}
