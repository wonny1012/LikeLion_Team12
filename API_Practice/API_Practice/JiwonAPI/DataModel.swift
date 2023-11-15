//
//  DataModel.swift
//  API_Practice
//
//  Created by kwon ji won on 11/15/23.
//

import Foundation

// https://itunes.apple.com/search?term=coldplay&entity=song

func getMethod(completion: @escaping (Result<[Song], Error>) -> Void) {
    //URL구조체 만들기
    guard let url = URL(string: "https://itunes.apple.com/search?term=coldplay&entity=song") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    //생성한 URL을 사x용하여 HTTP GET 요청을 설정합니다. 요청은 URLRequest 형식이며, HTTP 메소드는 "GET"으로 설정됩니다.
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // 요청을 가지고 데이터 작업세션 시작
    // URLSession.shared.dataTask(with:completionHandler:)
    URLSession.shared.dataTask(with: request) { data, response, error in
        //에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        // 데이터를 수신했는지 확인합니다. 데이터가 없으면 오류 메시지를 출력하고 함수를 종료합니다
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // JSON 디코딩
        do {
            let decoder = JSONDecoder()
                       let songResponse = try decoder.decode(SongResponse.self, from: safeData)
                       completion(.success(songResponse.songs))
                   } catch {
                       print("Error decoding JSON: \(error)")
                       completion(.failure(error))
        }
            
    }.resume()
}

struct Song: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
//        case artwork
    }
}

struct SongResponse: Decodable {
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey { // 인터넷 검색으로 불러온 json의 키 이름과 사용자가 설정한 이름이 다를때 매칭을 할 수 있도록
        case songs = "results" // 사용자 지정명 : songs, json key명 : result
    }
}
