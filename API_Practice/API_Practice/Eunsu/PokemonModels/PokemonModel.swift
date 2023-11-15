//
//  PokemonModel.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
//    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
//    let species: String
}

struct Species: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var sampleSpecies = Species(name: "Pokémon Flamm", url: "https://pokeapi.co/api/v2/pokemon-species/5/")
}

struct Generas: Codable {
    let genera: [Genera]
}

struct Genera: Codable {
    let genus: String
    let language: Language
}

struct Language: Codable {
    let name: String
}

