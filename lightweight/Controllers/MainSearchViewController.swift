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
    
    private var media: [MediaType: [Media]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self?.media = collection
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
        }
        
    }
    
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
}
