//
//  EunsuViewModel.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import Foundation
import SwiftUI

final class PokemonViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var species: Species?
    @Published var genras: Generas?
    @Published var searchText = ""
    
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
//        print(self.pokemonList)
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0 // if found nothing
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 9, height: 8, weight: 7, species: getSpecies(pokemon: pokemon)) //placeholder
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func getGenra(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.genras = Generas(genera: [Genera(genus: "Seed Pokémon?", language: Language(name: "en"))])
        
        pokemonManager.getPokemonSpecies(id: id) { data in
            DispatchQueue.main.async {
                self.genras = data
            }
        }
    }
  
    func getSpecies(pokemon: Pokemon) -> String {
        let id = getPokemonIndex(pokemon: pokemon)
//        let name = pokemon.name
        self.species = Species.sampleSpecies
        self.genras = Generas(genera: [Genera(genus: "Seed Pokémon?", language: Language(name: "en"))])
        
        pokemonManager.getPokemonSpecies(id: id) { data in
            DispatchQueue.main.async {
                self.genras = data
            }
        }
        
        if let species = genras?.genera {
            return species[0].genus
        }
        
        return "No Species"
    }
    
    /// adjust heigt and weight to meter and kilogram
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let strig = String(format: "%.2f", dValue / 10)
        
        return strig
    }
}
