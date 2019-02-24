//
//  AnimeController.swift
//  CodableTuto
//
//  Created by OuSS on 2/23/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import UIKit

class AnimeController: UITableViewController {
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    var anime: Anime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = anime?.title
        
        tableView.register(HeaderViewCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(AnimeViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderViewCell
        header.imageV.loadImage(imageUrl: anime?.imageUrl)
        return header.contentView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnimeViewCell
        cell.descLabel.text = anime?.synopsis
        return cell
    }

}
