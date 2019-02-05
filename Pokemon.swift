//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Cameron Milliken on 12/18/18.
//  Copyright © 2018 Cameron Milliken. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    enum CodingKeys: String, CodingKey {
    //case means they conform to what they say they are. 
    case name = "name"
    case id = "id"
    case abilities = "abilities"
    case sprite = "sprites"
    }
    
    let name: String
    let id: Int
    let abilities: [AbilityDictionary]
    let sprite: Sprite
    
    var abilityNames: String{
       let abilityArray = abilities.compactMap ( {$0.ability.name} )
        var returnString: String = ""
        
        
        for ability in abilityArray {
        if ability == abilityArray.first {
            returnString = ability.capitalized
        } else {
           
            returnString = "\(returnString) & \(ability.capitalized)"
        
            
        }
    }
        
        
        return returnString
}
struct AbilityDictionary: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprite: Codable {
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
    }
    let frontShiny: String?
}



}


