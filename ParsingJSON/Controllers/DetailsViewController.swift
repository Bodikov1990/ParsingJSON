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
        detailsLabel.text = person.details
        activityIndicator.startAnimating()
        NetworkingManager.shared.fetchImage(url: person.image ?? "") { image in
            self.avatarImageView.image = image
            
        }
        
    }


}
