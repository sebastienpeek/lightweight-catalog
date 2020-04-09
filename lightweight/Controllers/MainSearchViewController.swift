//
//  MainSearchViewController.swift
//  lightweight
//
//  Created by Sebastien Audeon on 4/8/20.
//  Copyright © 2020 Sebastien Audeon. All rights reserved.
//

import UIKit

import apple_data_package

class MainSearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var fetchedMedia: [MediaType: [Media]] = [:]
    private var media: [MediaType: [Media]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        // We want to make sure that we have any favorites automatically loaded.
        if let favorites = MediaManager().favorites() {
            self.media = favorites
        }
        
    }

}

extension MainSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Grab the text out of the search bar
        let query = searchBar.text
        
        // Pass the query off to the MediaManager.
        MediaManager().search(with: query) { [weak self] (collection, error) in
            
            if let error = error {
                // Alert the user.
                print(error.localizedDescription)
            }
            
            if let collection = collection {
                // When we get the media back, we want to save this in the fetched array.
                self?.fetchedMedia = collection
                DispatchQueue.main.async {
                    self?.reloadTable()
                }
            }
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.fetchedMedia.removeAll()
        self.reloadTable()
    }
    
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        let map = media.keys.map { type -> MediaType in
            return type
        }
        let key = map[section]
        
        return "\(key.rawValue.capitalized)"
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return media.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We need to get the values for the key for said section.
        let map = media.keys.map { type -> MediaType in
            return type
        }
        let key = map[section]
        
        return media[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell") as? MediaCell else {
            return UITableViewCell()
        }
        
        let map = media.keys.map { type -> MediaType in
            return type
        }
        let key = map[indexPath.section]
        
        guard let item = media[key]?[indexPath.row] else { return cell }
        cell.setup(with: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let map = media.keys.map { type -> MediaType in
            return type
        }
        let key = map[indexPath.section]
        
        guard let item = media[key]?[indexPath.row] else { return }
        
        // Do we need to favorite or unfavorite?
        if item.favorited {
            MediaManager().unfavorite(item)
            item.favorited = false
        } else {
            MediaManager().favorite(item)
            item.favorited = true
        }
        
        reloadTable()
        
    }
    
}

extension MainSearchViewController {
    
    private func reloadTable() {
        
        if let favorites = MediaManager().favorites() {
            self.media = favorites
        }
        
        if fetchedMedia.keys.count > 0 {
            self.media.merge(fetchedMedia) { (current, new) -> [Media] in
                return new
            }
        }
        
        self.tableView.reloadData()
        
    }
    
}
