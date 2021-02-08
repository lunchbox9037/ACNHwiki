//
//  Fish.swift
//  ACNHdex
//
//  Created by stanley phillips on 1/27/21.
//

import Foundation

struct Fish: Decodable {
    let name: Name
    let price: Int
    let catchPhrase: String
    let imageURL: URL
    let availability: Availability
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case catchPhrase = "catch-phrase"
        case imageURL = "image_uri"
        case availability
    }
}

struct Name: Decodable {
    let nameUSen: String

    enum CodingKeys: String, CodingKey {
        case nameUSen = "name-USen"
    }
}

struct Availability: Decodable {
    let location: String
    let rarity: String
    let monthArray: [Int]
    
    enum CodingKeys: String, CodingKey {
        case location
        case rarity
        case monthArray = "month-array-northern"
    }
}


