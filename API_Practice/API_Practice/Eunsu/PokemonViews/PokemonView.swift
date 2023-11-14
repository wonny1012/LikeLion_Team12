//
//  PokemonView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var vm: PokemonViewModel
    let pokemon: Pokemon
    let dimensions: Double = 140
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(.thinMaterial)
            .clipShape(Circle())
            
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    PokemonView(pokemon: Pokemon.samplePokemon).environmentObject(PokemonViewModel())
}
