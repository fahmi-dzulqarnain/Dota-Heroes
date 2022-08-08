//
//  HeroListViewModel.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 06/08/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

internal struct HeroListViewModel {
    internal var isConnected = BehaviorRelay<Bool>(value: false)
    internal var fullHeroes = BehaviorRelay<[Hero]>(value: [])
    internal var heroes = BehaviorRelay<[Hero]>(value: [])
    internal var heroFilters = BehaviorRelay<[String]>(value: [])
    internal var mainDomain = "https://api.opendota.com"
    
    let alamofire: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 13
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        return sessionManager
    }()
    
    internal func loadHeroes() {
        alamofire.request("\(mainDomain)/api/herostats")
            .validate()
            .responseDecodable(of: [Hero].self) { response in
                switch response.result {
                case .success(let heroResponse):
                    isConnected.accept(true)
                    fullHeroes.accept(heroResponse)
                    heroes.accept(heroResponse)
                    loadFilters()
                case .failure(let error):
                    isConnected.accept(false)
                    print("Error Fetching \(error.errorDescription ?? "There is an error while fetching a data")")
                }
            }
    }
    
    private func loadFilters() {
        var filters: [String] = ["All"]
        
        heroes.value.forEach({ hero in
            hero.roles?.forEach({ role in
                if !filters.contains(where: { $0 == role }) {
                    filters.append(role)
                }
            })
        })
        
        heroFilters.accept(filters)
    }
    
    internal func sortHeroes(by: SortType) {
        var rawHeroes = heroes.value
        
        switch by {
        case .baseAttack:
            rawHeroes.sort { first, second in
                first.baseAttackMin ?? 0 > second.baseAttackMin ?? 0
            }
        case .baseMana:
            rawHeroes.sort { first, second in
                first.baseMana ?? 0 > second.baseMana ?? 0
            }
        case .baseSpeed:
            rawHeroes.sort { first, second in
                first.moveSpeed ?? 0 > second.moveSpeed ?? 0
            }
        case .baseHealth:
            rawHeroes.sort { first, second in
                first.baseHealth ?? 0 > second.baseHealth ?? 0
            }
        }
        
        heroes.accept(rawHeroes)
    }
    
    internal func filterHeroes(by: String) {
        var rawHeroes = fullHeroes.value
        
        rawHeroes = rawHeroes.filter({ hero in
            hero.roles?.contains(by) ?? false
        })
        
        heroes.accept(rawHeroes)
    }
}
