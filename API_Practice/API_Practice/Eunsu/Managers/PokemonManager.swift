//
//  PokemonManager.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import Foundation

class PokemonManager {
    // read initial state of pokemon json
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    // get details for each pokemon
    func getDetailedPokemon(id: Int, _ completion: @escaping(DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/",
                              model: DetailPokemon.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
}
