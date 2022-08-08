//
//  HeroListViewModelTest.swift
//  Dota HeroesTests
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import Fakery
import Nimble
import Quick

@testable import Dota_Heroes

class HeroListViewModelTest: QuickSpec {
    override func spec() {
        var vm: HeroListViewModel?
        let faker = Faker()
        
        describe("Load Heroes") {
            context("Load All Heroes") {
                vm = HeroListViewModel()
                
                let mockedHero: [Hero] = []
                vm?.heroes.accept(mockedHero)
                
                expect(vm?.heroes.value.count).to(equal(0))
            }
            
            context("Load Filters") {
                vm = HeroListViewModel()
                
                let mockedString = faker.car.brand()
                let mockedArray = [mockedString]
                
                vm?.heroFilters.accept(mockedArray)
                
                expect(vm?.heroFilters.value.count).to(equal(1))
                expect(vm?.heroFilters.value[0]).to(equal(mockedString))
            }
        }
    }
}
