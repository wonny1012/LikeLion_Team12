//
//  PokemonDetailView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel //이미 존재하는 것을 언급하는것이므로 초기화하지 않는다.
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
//            PokemonView()
            
            VStack(spacing: 10) {
                Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                Text("**Weight**: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) kg")
                Text("**Height**: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) m")
            }
        }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
}
