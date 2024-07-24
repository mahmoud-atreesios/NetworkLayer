//
//  Leagues.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import Foundation

struct Leagues: Codable{
    let success: Int
    let result: [LeagueResults]
}

struct LeagueResults: Codable{
    let league_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}
