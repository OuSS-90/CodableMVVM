//
//  AnimeListController.swift
//  CodableTuto
//
//  Created by OuSS on 2/23/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import UIKit

class AnimeListController: UITableViewController {
    
    let cellId = "cellId"
    var animes = [AnimeViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Anime Season List"
        
        tableView.register(AnimeListCell.self, forCellReuseIdentifier: cellId)
        
        AnimeService.instance.getAnimeList { (season) in
            self.animes = season.anime.map{AnimeViewModel(anime: $0)}
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnimeListCell
        cell.animeViewModel = animes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeController = AnimeController(style: .grouped)
        animeController.animeViewModel = animes[indexPath.row]
        navigationController?.pushViewController(animeController, animated: true)
    }
}

