//
//  MainTableViewController.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 14.01.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var urlAddress = "https://my.api.mockaroo.com/fio.json?key=b2b55890"
    private var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getURL()
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
        DispatchQueue.global().async {
            guard let url = URL(string: person.image ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                content.image = UIImage(data: imageData)
                content.imageProperties.cornerRadius = tableView.rowHeight / 2
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailsVC.person = persons[indexPath.row]
    }

    private func getURL() {
        guard let url = URL(string: urlAddress) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.persons = try JSONDecoder().decode([Person].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
}
