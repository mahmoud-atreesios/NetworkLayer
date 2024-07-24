//
//  Leagues.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import Foundation

struct Movies: Codable{
    let page: Int
    let results: [Movie]
}

struct Movie: Codable{
    let backdrop_path: String?
    let title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let release_date: String?
    let vote_average: Double?
}
