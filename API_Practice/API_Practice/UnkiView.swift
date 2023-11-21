//
//  UnkiView.swift
//  API_Practice
//
//  Created by 권운기 on 11/22/23.
//

import SwiftUI

struct Comment: Codable, Identifiable {
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
            .onAppear(perform: loadData)
            .navigationBarTitle("댓글 목록")
        }
    }

    func loadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.comments = decodedData
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
        VStack(alignment: .leading) {
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
