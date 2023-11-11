//
//  ContentView.swift
//  API_Practice
//
//  Created by kwon ji won on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                //각자의 뷰를 넣어주세요!
                NavigationLink(destination: JiwonView(), label: {
                    Text("권운기님View")
                        .NavigationlabelModifier()
                })
                
                NavigationLink(destination: JiwonView(), label: {
                    Text("JiwonView")
                        .NavigationlabelModifier()
                })
                    
                NavigationLink(destination: JiwonView(), label: {
                    Text("김현진님View")
                        .NavigationlabelModifier()
                })
                
                NavigationLink(destination: JiwonView(), label: {
                    Text("양주원님View")
                        .NavigationlabelModifier()
                })
                
                NavigationLink(destination: JiwonView(), label: {
                    Text("정은수님View")
                        .NavigationlabelModifier()
                })
              
                Spacer()
            }
        }
    }
}


extension Text {
    func NavigationlabelModifier() -> some View {
        self
            .frame(width: 300, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .font(.title2)
    }
}

//struct navigationLavelStyle<Label>: View where Label: View {
//    var destination: some View
//    var label: Label
//
//    var body: some View {
//        NavigationLink(destination: destination, label: {
//            label
//                .frame(width: 300, height: 40)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(15)
//                .font(.title2)
//        })
//    }
//}


#Preview {
    ContentView()
}
