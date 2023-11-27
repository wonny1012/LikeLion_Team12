//
//  UnkiView.swift
//  API_Practice
//
//  Created by 권운기 on 11/22/23.
//

import SwiftUI

struct UnkiView: View {
    @State private var DailyBoxOfficeLists: [DailyBoxOfficeList] = []
    
    var body: some View {
        NavigationView {
            List(DailyBoxOfficeLists, id: \.rank) { movies in
                NavigationLink(destination: UnkiDetailView(DailyBoxOfficeLists: movies)) {
                    VStack {
                        Text("\(movies.rank). \(movies.movieNm)")
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("오늘의 영화 순위")
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20231126") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodeData = try
                    JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self.DailyBoxOfficeLists = decodeData.boxOfficeResult.dailyBoxOfficeList
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct UnkiDetailView: View {
    var DailyBoxOfficeLists: DailyBoxOfficeList
    
    var body: some View {
        VStack {
            Text("\(DailyBoxOfficeLists.rank). \(DailyBoxOfficeLists.movieNm)")
        }
    }
}

#Preview {
    UnkiView()
}
