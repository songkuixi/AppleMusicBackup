//
//  ViewController.swift
//  AppleMusicBackup
//
//  Created by Kuixi Song on 9/15/20.
//  Copyright © 2020 Kuixi Song. All rights reserved.
//

import UIKit
import StoreKit

class SongViewController: UITableViewController {
    
    var songs: [SongModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Music Backup"
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.reuseId)
    }

    @IBAction func backupAction(_ sender: UIBarButtonItem) {
        SKCloudServiceController.requestAuthorization { [weak self] (status) in
            AppleMusicAPI().fetchAllSongs({ (models) in
                self?.songs = models
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.reuseId) as! SongTableViewCell
        
        cell.config(songs[indexPath.row])
        
        return cell
    }

}
