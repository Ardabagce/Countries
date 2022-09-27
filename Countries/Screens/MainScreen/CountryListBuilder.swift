//
//  CountryListBuilder.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import UIKit

final class CountryListBuilder {
    
    static func make(repository: CountryListRepository) -> CountryListViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "CountryListViewController") as! CountryListViewController
        var viewModel: CountryListViewModelProtocol = CountryListViewModel()
        viewModel.countryListRepository = repository
        viewController.viewModel = viewModel
        return viewController
    }
}
