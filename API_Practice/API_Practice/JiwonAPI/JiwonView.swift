//
//  JiwonView.swift
//  API_Practice
//
//  Created by kwon ji won on 11/12/23.
//

import SwiftUI
//import URLImage

struct JiwonView: View {
    @State private var songs: [Song] = []
    
    var body: some View {
        NavigationView {
            List(songs, id: \.id) { song in
                HStack {
                    Image(systemName: "airplane")
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text(song.trackName)
                        Text(song.artistName)
//
                    }
                }
            }
            .navigationTitle("Song List")
            .onAppear(perform: loadData)
        }
    }
    
    //곡을 담아 온다.
    func loadData() {
        getMethod() { result in
            switch result {
            case .success(let songResponse) :
                self.songs = songResponse
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct ArtworkView: View {
    var image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Image("")
            }
        }
        .frame(width: 50, height: 50)
        .padding(.trailing, 5)
    }
}

//struct SongView: View {
//    @Binding var song: [Song]
//    
//    var body: some View {
//        HStack {
//            ArtworkView(image: ")
//                .padding(.trailing)
//            VStack(alignment: .leading) {
//                Text(song.trackName)
//                Text(song.artistName)
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//    }
//}



#Preview {
    JiwonView()
}
