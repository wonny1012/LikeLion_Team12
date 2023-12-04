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
    @State private var isLoadingData = false
    
    var body: some View {
        NavigationView {
            if !isLoadingData {
                VStack {
                    DatePicker(
                        "",
                        selection: $now,
                        displayedComponents: [.date]
                    )
                    .onChange(of: now) { // loadData로 now값 전달
                        loadData()
                    }
                    HStack {
                        Text("\("MM월dd일".stringFromDate(now: now)) 영화 순위")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(15)
                    Spacer()
                    Text("오늘의 데이터는 수집 중입니다.\n 날짜를 과거로 바꿔주세요.")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Spacer()
                }
                .padding()
            } else if now > Date() {
                VStack {
                    DatePicker(
                        "",
                        selection: $now,
                        displayedComponents: [.date]
                    )
                    .onChange(of: now) { // loadData로 now값 전달
                        loadData()
                    }
                    HStack {
                        Text("\("MM월 d일".stringFromDate(now: now)) 영화 순위")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(15)
                    Spacer()
                    Text("날짜가 미래로 되어있습니다.\n 날짜를 과거로 바꿔주세요.")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Spacer()
                }
                .padding()
            } else {
                List(DailyBoxOfficeLists, id: \.rank) { movies in
                    NavigationLink(destination: UnkiDetailView(DailyBoxOfficeLists: movies)) {
                        HStack {
                            Text("\(movies.rank).")
                                .bold()
                            if Int(movies.rankInten)! < 0 {
                                Text("(\(movies.rankInten))")
                                    .foregroundStyle(.blue)
                            } else if Int(movies.rankInten)! > 0 {
                                Text("(+\(movies.rankInten))")
                                    .foregroundStyle(.red)
                            } else {
                                Text("(-)")
                            }
                            Text("\(movies.movieNm)")
                                .bold()
                        }
                    }
                }
                .onAppear(perform: loadData)
                .toolbar {
                    DatePicker(
                        "",
                        selection: $now,
                        displayedComponents: [.date]
                    )
                    .onChange(of: now) { // loadData로 now값 전달
                        loadData()
                    }
                }
                .navigationTitle("\("MM월 d일".stringFromDate(now: now)) 영화 순위")
            }
        }
    }
    
    func loadData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let targetDt = formatter.string(from: now)
        
        guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(targetDt)") else {
            return
        }
        
        isLoadingData = true
        
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
        ScrollView{
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Rectangle() // asyncImage로 영화 포스터 가져올 공간. APIKEY 기다리는중
                        .frame(width: 270, height: 480)
                        .foregroundColor(.black)
                    Spacer()
                }
                Text("\(DailyBoxOfficeLists.rank). \(DailyBoxOfficeLists.movieNm)")
                    .font(.title)
                    .bold()
                Text("개봉일자: \(DailyBoxOfficeLists.openDt)")
                    .font(.title2)
                Text("오늘 관객수: \(DailyBoxOfficeLists.audiCnt)명")
                    .font(.title2)
                Text("누적 관객수: \(DailyBoxOfficeLists.audiAcc)명")
                    .font(.title2)
            }
            .padding()
            .navigationTitle("영화 정보")
            .navigationBarTitleDisplayMode(.inline)
        }
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
