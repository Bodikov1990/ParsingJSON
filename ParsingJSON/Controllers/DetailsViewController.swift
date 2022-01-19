//
//  DetailsViewController.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 15.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    var person: Person!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetch(from: person.image ?? "")
        detailsLabel.text = person.details
    }
    

    private func fetch(from url: String) {
        
        NetworkManager.shared.getImage(from: url) { result in
            switch result {
            case .success(let imageData):
                self.avatarImageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
