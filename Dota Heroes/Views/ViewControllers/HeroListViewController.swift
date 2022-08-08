//
//  ViewController.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 06/08/22.
//

import UIKit
import RxSwift

class HeroListViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    internal var disposeBag = DisposeBag()
    internal var collectionViewLayout: UICollectionViewFlowLayout {
        let verticalFlow = UICollectionViewFlowLayout()
        verticalFlow.scrollDirection = .vertical
        return verticalFlow
    }
    internal var filterCollectionViewLayout: UICollectionViewFlowLayout {
        let horizontalFlow = UICollectionViewFlowLayout()
        horizontalFlow.scrollDirection = .horizontal
        return horizontalFlow
    }
    
    internal lazy var viewModel = HeroListViewModel()
    internal lazy var bottomView = UIView().with(parent: mainView)
    internal lazy var disconnectedView = UIView().with(parent: mainView)
    internal lazy var heroesCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: collectionViewLayout).with(parent: mainView)
    internal lazy var filterCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: filterCollectionViewLayout).with(parent: mainView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupFilterCollectionView()
        setupHeroesCollectionView()
        setupBottomView()
        setupDisconnectedView()
        viewModel.loadHeroes()
        registerObservers()
    }
    
    func registerObservers() {
        viewModel.isConnected.subscribe(onNext: { [weak self] isConnected in
            self?.disconnectedView.isHidden = isConnected
        }, onError: { _ in
            print("Error subscribing")
        }).disposed(by: disposeBag)

        viewModel.heroes.subscribe(onNext: { [weak self] heroResponse in
            DispatchQueue.main.async {
                self?.heroesCollectionView.reloadData()
            }
        }, onError: { _ in
            print("Error subscribing")
        }).disposed(by: disposeBag)
        
        viewModel.heroFilters.subscribe(onNext: { [weak self] filterResponse in
            self?.filterCollectionView.reloadData()
        }, onError: { _ in
            print("Error subscribing")
        }).disposed(by: disposeBag)
    }
    
    private func setupNavbar() {
        title = "Dota 2"
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupDisconnectedView() {
        disconnectedView.centerXandYEdgeOf(mainView)
        
        let disconnectedImageView = UIImageView().with(parent: disconnectedView)
        disconnectedImageView.contentMode = .scaleAspectFit
        disconnectedImageView.setHeight(by: 96)
        disconnectedImageView.image = UIImage(named: "disconnected")
        disconnectedImageView.makeConstraint { constraint in
            constraint.topAnchor.equal(disconnectedView.topAnchor)
            constraint.trailingAnchor.equal(disconnectedView.trailingAnchor)
            constraint.leadingAnchor.equal(disconnectedView.leadingAnchor)
        }
        
        let disconnectedLabel = UILabel().with(parent: disconnectedView)
        disconnectedLabel.attributedText = "There is no connection".title().setAlign(.center)
        disconnectedLabel.makeConstraint { constraint in
            constraint.topAnchor.equal(disconnectedImageView.bottomAnchor, offset: .x16)
            constraint.trailingAnchor.equal(disconnectedView.trailingAnchor)
            constraint.leadingAnchor.equal(disconnectedView.leadingAnchor)
        }
    }
    
    private func setupBottomView() {
        bottomView.backgroundColor = .white
        bottomView.cornerRadius(spacing: .x16)
        bottomView.setHeight(by: 80)
        bottomView.makeConstraint { constraint in
            constraint.trailingAnchor.equal(mainView.trailingAnchor)
            constraint.bottomAnchor.equal(mainView.bottomAnchor)
            constraint.leadingAnchor.equal(mainView.leadingAnchor)
        }
        
        setupSortButton()
    }
    
    private func setupSortButton() {
        let sortButton = UIImageView().with(parent: bottomView)
        
        sortButton.centerYEdgeOf(bottomView)
        sortButton.makeConstraint { constraint in
            constraint.trailingAnchor.equal(bottomView.trailingAnchor, inset: .x16)
        }
        sortButton.tintColor = .systemBlue
        sortButton.image = UIImage(named: "filter-sort")
        sortButton.addTapGesture(target: self, action: #selector(onTapSortButton))
    }
    
    private func setupFilterCollectionView() {
        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.setHeight(by: 40)
        filterCollectionView.makeConstraint { constraint in
            constraint.topAnchor.equal(mainView.topAnchor)
            constraint.trailingAnchor.equal(mainView.trailingAnchor)
            constraint.leadingAnchor.equal(mainView.leadingAnchor)
        }
    }
    
    private func setupHeroesCollectionView() {
        heroesCollectionView.register(HeroCell.self, forCellWithReuseIdentifier: HeroCell.identifier)
        heroesCollectionView.delegate = self
        heroesCollectionView.dataSource = self
        
        heroesCollectionView.makeConstraint { constraint in
            constraint.topAnchor.equal(filterCollectionView.bottomAnchor, offset: .x20)
            constraint.trailingAnchor.equal(mainView.trailingAnchor)
            constraint.bottomAnchor.equal(mainView.bottomAnchor, inset: .x40)
            constraint.leadingAnchor.equal(mainView.leadingAnchor)
        }
    }
    
    @objc public func onTapSortButton() {
        let sortTableVC = SortTableViewController()
        sortTableVC.completion = { [weak self] sortType in
            self?.viewModel.sortHeroes(by: sortType ?? .baseAttack)
            self?.heroesCollectionView.reloadData()
        }
        
        let controller = UINavigationController(rootViewController: sortTableVC)
        controller.modalPresentationStyle = .formSheet
        self.present(controller, animated: true)
    }
}

extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == heroesCollectionView {
            return viewModel.heroes.value.count
        }
        return viewModel.heroFilters.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == heroesCollectionView {
            let cell = heroesCollectionView.dequeueReusableCell(withReuseIdentifier: HeroCell.identifier, for: indexPath) as! HeroCell
            let hero = viewModel.heroes.value[indexPath.row]
            let imageURL = viewModel.mainDomain + (hero.img ?? "")
            
            cell.setContent(imageURL: imageURL, heroName: hero.localizedName ?? "")
        
            return cell
        }
        
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
        let hero = viewModel.heroFilters.value[indexPath.row]
        
        if title == hero {
            cell.setContent(filterName: hero, backgroundColor: .white)
        } else {
            cell.setContent(filterName: hero)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == heroesCollectionView {
            let thirdOfScreen = (view.frame.size.width / 3) - 3
            return CGSize(width: thirdOfScreen, height: thirdOfScreen / 0.85)
        }
        
        return CGSize(width: 95, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView == heroesCollectionView) ? 1 : 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView == heroesCollectionView) ? 1 : 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        heroesCollectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == heroesCollectionView {
            let controller = HeroDetailViewController()
            controller.viewModel.chooseHero(viewModel.heroes.value[indexPath.row])
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let selectedFilter = viewModel.heroFilters.value[indexPath.row]
            title = selectedFilter
            filterCollectionView.reloadData()
            
            if selectedFilter != "All" {
                viewModel.filterHeroes(by: selectedFilter)
                heroesCollectionView.reloadData()
            } else {
                viewModel.loadHeroes()
                heroesCollectionView.reloadData()
            }
        }
    }
}
