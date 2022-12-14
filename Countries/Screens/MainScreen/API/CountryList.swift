//
//  CountryList.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData
import UIKit

protocol CountryListRepository {
    var countryListDatasource: BehaviorRelay<[CountryModel]> { get set }
    var isLoading: BehaviorRelay<Bool> { get set }
    var onError: BehaviorRelay<Bool> { get set }
    func getCountryList(limit: Int)
    func changeFavoriteCountry(code: String, isFav: Bool)
}

final class CountryListRepositoryImplementation: CountryListRepository {
    
    private var limit: Int = 10
    private var bag = DisposeBag()
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var onError = BehaviorRelay<Bool>(value: false)
    var countryListDatasource = BehaviorRelay<[CountryModel]>(value: [])
    
    func getCountryList(limit: Int) {
        guard let url = URL.getContryList(limit: limit) else { return }
        URLRequest.load(resource: Resource<Country>(url: url))
            .observe(on: MainScheduler.instance)
            .do(onError: { _ in self.onError.accept(true) })
                .do(onDispose: { [isLoading] in isLoading.accept(false) })
                    .subscribe(onNext: { [weak self] countryListResponse in
                        guard let self = self else { return }
                        
                        let favoriteCountries = self.getFavorites()
                        self.updateSavedCountryListDatasource(with: countryListResponse.data.map({
                            CountryModel(code: $0.code, name: $0.name, isFav: favoriteCountries.contains($0.code))})
                        )
                    })
                    .disposed(by: bag)
                    }
    
    func changeFavoriteCountry(code: String, isFav: Bool) {
        if isFav {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"SavedCountries")
            
            fetchRequest.predicate = NSPredicate(format: "savedCountryCode = %@", "\(code)")
            do
            {
                let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for entity in fetchedResults! {
                    
                    context.delete(entity)
                }
                try context.save()
            }
            catch _ {
                print("Could not be deleted!")
            }
        } else {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            let newCountry = NSEntityDescription.insertNewObject(forEntityName: "SavedCountries", into: context)
            
            newCountry.setValue(code, forKey: "savedCountryCode")
            
            do {
                try context.save()
            } catch  {
                print("Could not be saved!")
            }
        }
        let favoriteCountries = self.getFavorites()
        self.updateSavedCountryListDatasource(with: countryListDatasource.value.map({
            CountryModel(code: $0.code, name: $0.name, isFav: favoriteCountries.contains($0.code))})
        )
    }
    
    private func getFavorites() -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCountries")
        var countryCodes: [String] = []
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let savedCountryCode = result.value(forKey: "savedCountryCode") as? String else { return [] }
                    countryCodes.append(savedCountryCode)
                }
            }
        } catch {
            print("Error")
        }
        return countryCodes
    }
}

extension CountryListRepositoryImplementation {
    private func updateSavedCountryListDatasource(with country: [CountryModel]) {
        self.countryListDatasource.accept(country)
    }
}
