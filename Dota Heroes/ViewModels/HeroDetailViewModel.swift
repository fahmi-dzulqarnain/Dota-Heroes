//
//  HeroDelegate.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import Foundation
import RxSwift
import RxCocoa

class HeroDetailViewModel {
    var heroSelected = BehaviorRelay<Hero?>(value: nil)
    var mainDomain = "https://api.opendota.com"
    
    func chooseHero(_ hero: Hero) {
        heroSelected.accept(hero)
    }
}
