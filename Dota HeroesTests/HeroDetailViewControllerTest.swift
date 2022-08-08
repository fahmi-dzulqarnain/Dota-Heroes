//
//  HeroDetailViewController.swift
//  Dota HeroesTests
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import XCTest

@testable import Dota_Heroes

class HeroDetailViewControllerTest: XCTestCase {
    var vc: HeroDetailViewController!
    
    override func setUpWithError() throws {
        vc = HeroDetailViewController()
    }

    override func tearDownWithError() throws {
        vc = nil
    }

    func tableViewSections() throws {
        XCTAssertEqual(vc.heroDetailTableView.numberOfSections, 6)
        XCTAssertEqual(vc.heroDetailTableView.sectionHeaderHeight, 23.0)
    }
}
