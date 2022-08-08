//
//  HeroDetailViewController.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import UIKit
import RxSwift

class HeroDetailViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel = HeroDetailViewModel()
    
    internal lazy var heroDetailTableView: UITableView = UITableView().with(parent: view)
    
    override func loadView() {
        super.loadView()
        
        setupTableView()
        registerObservers()
    }
    
    private func registerObservers() {
        viewModel.heroSelected.subscribe(onNext: { [weak self] hero in
            self?.title = hero?.localizedName
            self?.heroDetailTableView.reloadData()
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        heroDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        heroDetailTableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        heroDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        heroDetailTableView.allowsSelection = false
        heroDetailTableView.delegate = self
        heroDetailTableView.dataSource = self
        heroDetailTableView.makeConstraint { constraint in
            constraint.topAnchor.equal(view.topAnchor)
            constraint.leadingAnchor.equal(view.leadingAnchor)
            constraint.bottomAnchor.equal(view.bottomAnchor)
            constraint.trailingAnchor.equal(view.trailingAnchor)
        }
    }
}

extension HeroDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 4
        case 4:
            return 1
        case 5:
            return viewModel.heroSelected.value?.roles?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .value1, reuseIdentifier: "CellWithDetail")
        let hero = viewModel.heroSelected.value
        
        let imageURL = viewModel.mainDomain + (hero?.img ?? "")
        let titleDetail = [
            "➕ Base Health", "🍶 Base Mana", "🛡 Base Armor", "⚔️ Base Attack"
        ]
        let detail: [Any] = [
            hero?.baseHealth ?? 0,
            hero?.baseMana ?? 0,
            hero?.baseArmor ?? 0.0,
            "\(hero?.baseAttackMin ?? 0) - \(hero?.baseAttackMax ?? 0)"
        ]
        
        switch indexPath.section {
        case 0:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            imageCell.setImage(URLAddress: imageURL)
            return imageCell
        case 1:
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CompleteCell")
            cell.imageView?.image = UIImage(named: "thumbnail-default")
            cell.imageView?.loadFrom(URLAddress: imageURL)
            cell.textLabel?.text = hero?.localizedName ?? ""
            cell.detailTextLabel?.text = hero?.primaryAttr?.uppercased() ?? ""
        case 2:
            cell.textLabel?.text = "Attack Type"
            cell.detailTextLabel?.text = hero?.attackType ?? ""
        case 3:
            cell.textLabel?.text = titleDetail[indexPath.row]
            cell.detailTextLabel?.text = String(describing: detail[indexPath.row])
        case 4:
            cell.textLabel?.text = "🥾 Move Speed"
            cell.detailTextLabel?.text = String(describing: hero?.moveSpeed ?? 0)
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
            cell.textLabel?.text = hero?.roles?[indexPath.row]
        default:
            cell.backgroundColor = .red
        }
        
        return cell
    }
}
