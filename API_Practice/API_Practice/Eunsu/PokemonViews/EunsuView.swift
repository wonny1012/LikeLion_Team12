//
//  EunsuView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct EunsuView: View {
    @StateObject var vm = ViewModel()
    
    private let adaptveColumns = [
        GridItem(.adaptive(minimum: 150)) //앱을 가로로 돌리면 줄이 눌어난다.
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptveColumns, spacing: 10) {
                    ForEach(vm.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonView(pokemon: pokemon)
                        }
                    }
                }
            }
        }
        .environmentObject(vm)
    }
}

#Preview {
    EunsuView()
}
