//
//  EunsuView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct EunsuView: View {
    @EnvironmentObject var pokemonVM: PokemonViewModel
    
    private let adaptveColumns = [
        GridItem(.adaptive(minimum: 150)) //앱을 가로로 돌리면 줄이 눌어난다.
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptveColumns, spacing: 10) {
                    ForEach(pokemonVM.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonView(pokemon: pokemon)
                        }
                    }
                }
                .animation(.easeIn(duration: 0.3), value: pokemonVM.filteredPokemon.count) //value의 값이 바뀌면 aninmation이 작동한다.
                .navigationTitle("Pokemons")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $pokemonVM.searchText)
        }
    }
}

#Preview {
    EunsuView().environmentObject(PokemonViewModel())
}
