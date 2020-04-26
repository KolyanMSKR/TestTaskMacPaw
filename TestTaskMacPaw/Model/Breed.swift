//
//  Breed.swift
//  TestTaskMacPaw
//
//  Created by Admin on 16.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import Foundation

struct Breed: Codable {
    let id, name: String?
    let description: String?
    let wikipediaURL: String?
    let url: String?
    let imgWidth: Int?
    let imgHeight: Int?
    let breeds: [BreedDescription]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case wikipediaURL = "wikipedia_url"
        case url
        case imgWidth = "width"
        case imgHeight = "height"
        case breeds
    }
}

struct BreedDescription: Codable {
    let name: String?
}
