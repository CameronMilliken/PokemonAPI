//
//  PokemonViewController.swift
//  PokemonAPI
//
//  Created by Cameron Milliken on 12/18/18.
//  Copyright © 2018 Cameron Milliken. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        PokemonController.shared.fetchPokemon(for: searchTerm) { (pokemon) in
            
            guard let pokemon = pokemon else {return}
            
            PokemonController.shared.fetchImageFor(pokemon: pokemon, completion: { (image) in
                DispatchQueue.main.async {
                    
                    self.nameLabel.text = pokemon.name.capitalized
                    self.idLabel.text = "\(pokemon.id)"
                    self.abilitiesLabel.text = pokemon.abilityNames
                    self.spriteImageView.image = image
                }
                    
            })
            
        }
                
    }
}

