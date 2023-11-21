//
//  UnkiView.swift
//  API_Practice
//
//  Created by 권운기 on 11/22/23.
//

import SwiftUI

struct Comment: Codable, Identifiable { // comment api struct
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

struct UnkiView: View {
    @State private var comments: [Comment] = []

    var body: some View {
        NavigationView {
            List(comments) { comment in
                // 각 댓글을 누르면 CommentDetail로 이동하는 NavigationLink
                NavigationLink(destination: CommentDetail(comment: comment)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("이름: \(comment.name)")
                            .font(.headline)
                        Text("이메일: \(comment.email)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("내용: \(comment.body)")
                            .font(.body)
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear(perform: loadData) // 화면이 나타날 때 데이터 로드
            .navigationBarTitle("댓글 목록")
        }
    }

    func loadData() {  // comment api를 가져오는 함수
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            return
        }
        // 데이터를 가져오고 디코딩
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.comments = decodedData // 가져온 데이터로 댓글 목록 업데이트
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct CommentDetail: View {
    var comment: Comment

    var body: some View {
        VStack(alignment: .leading) { // 선택된 댓글의 상세 정보를 표시하는 뷰
            Text("이름: \(comment.name)")
                .font(.headline)
                .padding(1)
            Text("이메일: \(comment.email)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(1)
            Text("내용: \(comment.body)")
                .font(.body)
                .foregroundColor(.black)
                .padding(1)
            Spacer()
        }
        .padding(1)
        .navigationBarTitle("댓글 상세 정보")
    }
}

#Preview {
    UnkiView()
}
