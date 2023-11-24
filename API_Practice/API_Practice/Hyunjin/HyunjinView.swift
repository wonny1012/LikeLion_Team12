//
//  HyunjinView.swift
//  API_Practice
//
//  Created by KHJ on 2023/11/16.
//

import SwiftUI
import NukeUI


struct HyunjinView: View {
    @State private var nfts = [NFT]()
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    let nftCollections = ["doodles-official", "azuki", "boredapeyachtclub", "meebits", "thecaptainz", "thepotatoz"]
    var body: some View {
        ScrollView {
            // 스크롤 버튼
            collectionsHScrollView()
            // NFTs
            LazyVGrid(columns: columns) {
                ForEach(nfts, id: \.self) { nft in
                    NFTGridView(nft: nft)
                }
            }
            .padding()
        }
        .navigationTitle("NFTs ⛵️")
        .task {
            nfts = await getNFTs(of: nftCollections[0])
        }
    }
}

// MARK: - SubViews

// 새로운 뷰 구조체로 분리 ( 변수를 선언해 사용할 값을 불러와야 함 ).
struct NFTGridView: View {
    let nft: NFT
    var body: some View {
        if let nfturl = nft.image_url {
            LazyImage(url: URL(string: nfturl)) { state in
                if let image = state.image {
                    VStack(alignment: .leading) {
                        image
                            .resizable()
                            .scaledToFit()
                        HStack {
                            Text(
                                (nft.name == nil) ?
                                "N/A " + "#" + nft.identifier : nft.name!
                            )
                            Spacer()
                            HeartButton()
                        }
                        .padding()
                    }
                } else if state.error != nil {
                } else {
                    ProgressView()
                        .frame(width: 150, height: 150)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.1))
            )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .shadow(radius: 3, x: 0, y: 0)
            )
        }
    }
}

struct HeartButton: View {
    @State var isLiked = false
    @State var scale: CGFloat = 1
    var body: some View {
        Image(systemName: isLiked ? "heart.fill" : "heart")
            .font(.body)
            .foregroundColor(isLiked ? .blue : .gray)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.2))
            .onTapGesture {
                isLiked.toggle()
                scale = isLiked ? 1.2 : 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    scale = 1
                }
            }
    }
}

// 뷰를 리턴하는 함수로 확장 ( 내부 프라퍼티를 사용할 수 있는 장점 )
extension HyunjinView {
    func collectionsHScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(nftCollections, id: \.self) { collectionName in
                    Button(collectionName) {
                        Task {
                            nfts = await getNFTs(of: collectionName)
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
    }
}
// MARK: - Functions

extension HyunjinView {
    // 해당 콜렉션의 NFTs 불러오기
    func getNFTs(of collection: String) async -> [NFT] {
        let url = URL(string: "https://api.opensea.io/api/v2/collection/\(collection)/nfts")!
        var request = URLRequest(url: url)
        request.addValue("3f110e29c9aa430faa420345b63288d0", forHTTPHeaderField: "X-API-KEY")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(Collection.self, from: data)
            return decodedData.nfts
        } catch {
            print(error)
            return []
        }
    }
}

#Preview {
    NavigationStack {
        HyunjinView()
    }
}
