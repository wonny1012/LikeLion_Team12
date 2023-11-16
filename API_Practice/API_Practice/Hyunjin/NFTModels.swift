//
//  Models.swift
//  API_Practice
//
//  Created by KHJ on 2023/11/16.
//

import Foundation

// MARK: - Collection
struct Collection: Codable {
    let nfts: [NFT]
    let next: String
}

// MARK: - Nft
struct NFT: Codable, Hashable {
    let identifier, collection, contract, token_standard: String
    let name: String?
    let description: String?
    let image_url: String?
    let metadata_url, created_at: String?
    let updated_at: String
    let is_disabled, is_nsfw: Bool
}
