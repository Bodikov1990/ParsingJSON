//
//  MainTableViewController.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 14.01.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataWithAlomafire(Link.mainUrl.rawValue)
        tableView.rowHeight = 50
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showPerson", for: indexPath)
        let person = persons[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = person.fullName
        
        
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailsVC.person = persons[indexPath.row]
    }


}

extension MainTableViewController {
    func fetchDataWithAlomafire(_ url: String) {
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success( let persons):
                self.persons = persons
                self.tableView.reloadData()
            case .failure( let error):
                print(error)
            }
        }
    }
}
