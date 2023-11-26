//
//  GitHubUsersModel.swift
//  API_Practice
//
//  Created by 양주원 on 11/25/23.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}
