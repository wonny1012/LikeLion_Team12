//
//  PokemonDetailView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var pokemonVM: PokemonViewModel //이미 존재하는 것을 언급하는것이므로 초기화하지 않는다.
    let pokemon: Pokemon
    let species: Species
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
            VStack(spacing: 10) {
                Text("**ID**: \(pokemonVM.pokemonDetails?.id ?? 0)")
                Text("**Weight**: \(pokemonVM.formatHW(value: pokemonVM.pokemonDetails?.weight ?? 0)) kg")
                Text("**Height**: \(pokemonVM.formatHW(value: pokemonVM.pokemonDetails?.height ?? 0)) m")
                Text("**Species**: \(pokemonVM.genras?.genera[0].genus ?? "Test")")
            }
        }
        .onAppear {
            pokemonVM.getDetails(pokemon: pokemon)
            pokemonVM.getGenra(pokemon: pokemon)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon, species: Species.sampleSpecies).environmentObject(PokemonViewModel())
}
