//
//  CountryDetailApiProtocol.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation
import RxSwift

protocol CountryDetailApiProtocol {
    func getCountryDetail(code: String) -> Observable<CountryDetail>
}
final class CountryDetailApiImplementation: CountryDetailApiProtocol {
    func getCountryDetail(code: String) -> Observable<CountryDetail> {
        guard let url = URL.getContryDetails(code: code) else { return .empty() }
        return URLRequest.load(resource: Resource<CountryDetail>(url: url))
    }
}
