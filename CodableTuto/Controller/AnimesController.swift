//
//  AnimeListController.swift
//  CodableTuto
//
//  Created by OuSS on 2/23/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import UIKit
import JGProgressHUD

class AnimesController: UITableViewController {
    
    let cellId = "cellId"
    let animesViewModel = AnimesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupObservers()
        
        animesViewModel.fetchAnimes()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Anime Season List"
    }
    
    fileprivate func setupTableView() {
        tableView.register(AnimeListCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }

    fileprivate func setupObservers() {
        let hud = JGProgressHUD(style: .dark)
        
        animesViewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading == true {
                hud.textLabel.text = "Loading"
                guard let view = self.navigationController?.view else { return }
                hud.show(in: view)
            } else {
                hud.dismiss()
            }
        }
        
        animesViewModel.animes.bind(observer: { [unowned self] (animes) in
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animesViewModel.animes.value?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnimeListCell
        cell.anime = animesViewModel.animes.value?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeController = DetailsAnimeController()
        guard let anime = animesViewModel.animes.value?[indexPath.row] else { return }
        animeController.animeViewModel = AnimeViewModel(anime: anime)
        navigationController?.pushViewController(animeController, animated: true)
    }
}

