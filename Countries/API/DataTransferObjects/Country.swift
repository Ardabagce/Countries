//
//  Country.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation

struct Country: Decodable {
    let data: [Datum]
}


struct Datum: Decodable {
    let code: String
    let name, wikiDataID: String
    
    enum CodingKeys: String, CodingKey {
        case code, name
        case wikiDataID = "wikiDataId"
    }
}
