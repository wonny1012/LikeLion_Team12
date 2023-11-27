//
//  UnkiView.swift
//  API_Practice
//
//  Created by 권운기 on 11/22/23.
//

import SwiftUI

struct UnkiView: View {
    @State private var DailyBoxOfficeLists: [DailyBoxOfficeList] = []
    @State public var now = Date()
    
    var body: some View {
        DatePicker(
                "",
                selection: $now,
                displayedComponents: [.date]
            )
        NavigationView {
            List(DailyBoxOfficeLists, id: \.rank) { movies in
                NavigationLink(destination: UnkiDetailView(DailyBoxOfficeLists: movies)) {
                    VStack {
                        Text("\(movies.rank). \(movies.movieNm)")
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("\("MM월dd일".stringFromDate(now: now)) 영화 순위")
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

struct UnkiDetailView: View { // 디테일 뷰
    var DailyBoxOfficeLists: DailyBoxOfficeList
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(DailyBoxOfficeLists.rank). \(DailyBoxOfficeLists.movieNm)")
                .font(.title)
                .bold()
            Text("개봉일자: \(DailyBoxOfficeLists.openDt)")
                .font(.title2)
            Text("오늘 관객수: \(DailyBoxOfficeLists.audiCnt)명")
                .font(.title2)
            Text("누적 관객수: \(DailyBoxOfficeLists.audiAcc)명")
                .font(.title2)
            Spacer()
        }
        .padding()
    }
}

extension String { // 날짜 포멧 변경
    func stringFromDate(now: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}

#Preview {
    UnkiView()
}
