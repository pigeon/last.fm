
//
//  SearchSearchViewController.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import UIKit

class SearchViewController: UIViewController, SearchViewInput,UISearchBarDelegate {

    var output: SearchViewOutput!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        self.createSearchBar()
        output.viewIsReady()
    }

    func createSearchBar() {
        if( output.scopeBarPresent() ) {
            searchBar.delegate = self
        }

    }
    
    func clearSearchResults() {
        self.output.clearSearchResults()
    }

    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ errorMsg: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorMsg, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.output.prepare(for:segue)
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = output.scopeBarTitles()
        searchBar.selectedScopeButtonIndex = output.selectedScopeBarTitle().rawValue
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.output.search(term: text)
            self.searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            clearSearchResults()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.output.setSearchCondition(selectedScope)
        self.clearSearchResults()
    }
    
}

extension SearchViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setSearchResult(self.output.match(forRow: indexPath.row))
        self.output.image(forRow: indexPath.row) { (image) in
            cell.imageView?.image = image
        }
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output.numberOfSearchMathes()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output.selected(row:indexPath.row)
    }
}
