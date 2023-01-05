//
//  AnimeTableViewController.swift
//  AnimeAPI
//
//  Created by Marat on 04.01.2023.
//

import UIKit

class AnimeTableViewController: UITableViewController {
    
    var animeList: Animes? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.identifier)
        tableView.rowHeight = 150
    }
    
    private func fetchData() {
        ApiManager.shared.getAnimeList { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let animeList):
                self?.animeList = animeList.anime
            }
        }
    }
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animeList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.identifier, for: indexPath) as! AnimeTableViewCell

        cell.anime = animeList?[indexPath.row]

        return cell
    }

}
