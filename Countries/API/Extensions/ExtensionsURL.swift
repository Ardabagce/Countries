//
//  ExtensionsURL.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation
enum Endpoints {
    static let apiKey = "349e7bc5c6msh1779aa8caf3db89p161d82jsn2885a4bf4ae1"
    static let base = "https://wft-geo-db.p.rapidapi.com/"
    static let apiKeyParam = "x-rapidapi-key=\(apiKey)"
}

extension URL {
    
    static func getContryList(limit: Int) -> URL? {
        URL(string: Endpoints.base + "/geo/countries" + "?limit=\(limit)&" + Endpoints.apiKeyParam)
    }
    
    static func getContryDetails(code: String) -> URL? {
        URL(string: Endpoints.base + "/geo/countries/\(code)?" + Endpoints.apiKeyParam)
    }
}
