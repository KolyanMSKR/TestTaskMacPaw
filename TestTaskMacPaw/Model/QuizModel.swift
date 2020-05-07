//
//  QuizModel.swift
//  TestTaskMacPaw
//
//  Created by Admin on 07.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import Foundation

class QuizModel {
    
    private static let breeds = ["abys", "aege", "abob", "acur", "asho", "awir", "amau", "amis", "bali", "bamb",
                          "beng", "birm", "bomb", "bslo", "bsho", "bure", "buri", "cspa", "ctif", "char",
                          "chau", "chee", "csho", "crex", "cymr", "cypr", "drex", "dons", "lihu", "emau",
                          "ebur", "esho", "hbro", "hima", "jbob", "java", "khao", "kora", "kuri", "lape",
                          "mcoo", "mala", "manx", "munc", "nebe", "norw", "ocic", "orie", "pers", "pixi",
                          "raga", "ragd", "rblu", "sava", "sfol", "srex", "siam", "sibe", "sing", "snow",
                          "soma", "sphy", "tonk", "toyg", "tang", "tvan", "ycho"]
    
    private static let answers = ["Abyssinian", "Aegean", "American Bobtail", "American Curl", "American Shorthair",
                           "American Wirehair", "Arabian Mau", "Australian Mist", "Balinese", "Bambino", "Bengal",
                           "Birman", "Bombay", "British Longhair", "British Shorthair", "Burmese", "Burmilla",
                           "California Spangled", "Chantilly-Tiffany", "Chartreux", "Chausie", "Cheetoh",
                           "Colorpoint Shorthair", "Cornish Rex", "Cymric", "Cyprus", "Devon Rex", "Donskoy",
                           "Dragon Li", "Egyptian Mau", "European Burmese", "Exotic Shorthair", "Havana Brown",
                           "Himalayan", "Japanese Bobtail", "Javanese", "Khao Manee", "Korat", "Kurilian", "LaPerm",
                           "Maine Coon", "Malayan", "Manx", "Munchkin", "Nebelung", "Norwegian Forest Cat", "Ocicat",
                           "Oriental", "Persian", "Pixie-bob", "Ragamuffin", "Ragdoll", "Russian Blue", "Savannah",
                           "Scottish Fold", "Selkirk Rex", "Siamese", "Siberian", "Singapura", "Snowshoe", "Somali",
                           "Sphynx", "Tonkinese", "Toyger", "Turkish Angora", "Turkish Van", "York Chocolate"]
    
    static func getRandomBreed() -> String? {
        return breeds.randomElement()
    }
    
    static func getRandomAnswer() -> String? {
        return answers.randomElement()
    }
    
}
