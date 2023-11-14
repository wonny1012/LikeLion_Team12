//
//  EunsuView.swift
//  API_Practice
//
//  Created by Eunsu JEONG on 11/14/23.
//

import SwiftUI

struct EunsuView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .environmentObject(vm)
    }
}

#Preview {
    EunsuView()
}
