//
//  PokemonController.swift
//  PokemonAPI
//
//  Created by Cameron Milliken on 12/18/18.
//  Copyright © 2018 Cameron Milliken. All rights reserved.
//

import UIKit

class PokemonController{
    
    static let shared = PokemonController()
    
    static let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")
    
    func fetchPokemon(for searchTerm: String, completion: @escaping (Pokemon?) -> Void){
        guard let searchURL = PokemonController.baseURL?.appendingPathComponent(searchTerm.lowercased()) else {
            completion(nil)
            return
        }
        
        
        let dataTask = URLSession.shared.dataTask(with: searchURL) { (data, _, error) in
            if let error = error {
                print("🤬 There was an error catching them all from the API. \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder  = JSONDecoder()
                let decodedData = try decoder.decode(Pokemon.self, from: data)
                
                completion(decodedData)
                
            } catch {
                print("🤬 Error decoding data from JSON \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    func fetchImageFor(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void ) {
        
        guard let imageURLAsString = pokemon.sprite.frontShiny else {completion(nil); return}
        
        guard let imageURL = URL(string: imageURLAsString) else { print("error converting image string to URL")
            completion(nil)
            return
        }
        
            
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error with image data task \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil);return}
            
            let image = UIImage(data: data)
            completion(image)
            
            
        }
        dataTask.resume() 
    }

}
