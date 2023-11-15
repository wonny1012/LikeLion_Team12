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
                    //수정할 예정
//질문 예정  Image("https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/63/4a/b8/634ab8d4-abbd-d00a-8913-3048bc89cb4d/075679749123_01.jpg/60x60bb.jpg")
                    Image(systemName: "airplane")
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text(song.trackName)
                        Text(song.artistName)
                    }
                    Spacer()
                    //클릭을 했을 때 youtube로 넘어가게 만들었습니다.
                    Link(destination: URL(string: "https://www.youtube.com/results?search_query=\(song.trackName)+\(song.artistName)")
                         ?? URL(string: "https://www.youtube.com")!) {
                            Image(systemName: "star")
                                .background()
                                .clipShape(Circle())
                                .foregroundColor(.black)
                        
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


#Preview {
    JiwonView()
}
