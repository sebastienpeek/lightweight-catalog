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
    
    private var media: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension MainSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Grab the text out of the search bar
        let query = searchBar.text
        
        // Pass the query off to the MediaManager.
        MediaManager().search(with: query) { (collection, error) in
            print(collection)
            print(error)
        }
        
    }
    
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell") as? MediaCell else {
            return UITableViewCell()
        }
        
        return cell
        
    }
    
}
