//
//  HeroData.swift
//  grainProtectors
//
//  Created by GIRA on 27/01/22.
//

import Foundation
import UIKit

struct HeroData: Codable {
    let name : String
    let powerstats: PowerStats
    let biography: Biography
    //    let appearance : Appearance
    //    let work : Work
    //    let connections : Connections
    let image : Image
}

struct PowerStats : Codable{
        let intelligence : String
        let strength : String
        let speed : String
        let durability : String
        let power : String
        let combat : String
}

struct Biography : Codable  {
    //let fullName : String
    //    let alterEgos : String
    //    let aliases : String
    let city : String
    //    let firstApperance : String
    let publisher : String
    let alignment : String
    
    enum CodingKeys: String, CodingKey{
        case city = "place-of-birth"
        case publisher
        case alignment
    }
}

//struct Appearance : Codable {
//    
//}
//
//struct Work : Codable {
//    
//}
//
//struct Connections : Codable {
//    
//}

struct Image : Codable {
    let url : String
}
