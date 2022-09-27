//
//  CountryDetailed.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation

struct CountryDetail: Decodable {
    let data: DataClass
}


struct DataClass: Decodable {
    let code: String
    let flagImageURI: String
    let name: String
    let wikiDataID: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case flagImageURI = "flagImageUri"
        case name
        case wikiDataID = "wikiDataId"
    }
}
