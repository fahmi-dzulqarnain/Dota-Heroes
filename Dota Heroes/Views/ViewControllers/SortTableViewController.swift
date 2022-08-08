//
//  SortTableViewController.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import UIKit

class SortTableViewController: UITableViewController {
    let sortType: [SortType] = [
        .baseAttack,
        .baseHealth,
        .baseMana,
        .baseSpeed
    ]
    
    internal var completion: ((SortType?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortCell")
    }
    
    private func setupNavbar() {
        title = "Sort Heroes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(applySort))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortType.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
        cell.textLabel?.text = sortType[indexPath.row].rawValue
        return cell
    }
    
    @objc private func applySort() {
        guard let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        completion?(sortType[index])
        dismiss(animated: true)
    }
}
