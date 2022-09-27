//
//  SavedCountryBuilder.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation
import UIKit

final class SavedCountriesBuilder {
    static func make(repository: CountryListRepository) -> SavedCountriesViewController {
        let storyboard = UIStoryboard(name: "SavedCountries", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SavedCountriesViewController") as! SavedCountriesViewController
        var viewModel: SavedCountriesViewModelProtocol = SavedCountriesViewModel()
        viewModel.countryListRepository = repository
        viewController.viewModel = viewModel
        return viewController
    }
}
