//
//  PersonsTBCell.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 20.01.2022.
//

import UIKit

class PersonsTBCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel! {
        didSet {
            fullNameLabel.contentMode = .scaleAspectFit
            fullNameLabel.clipsToBounds = true
            fullNameLabel.layer.cornerRadius = fullNameLabel.frame.height / 2
        }
    }
    
    var person: Person!
    
    func configure(from url: String) {
        NetworkManager.shared.getImage(from: url) { result in
            switch result {
            case .success(let imageData):
                self.avatarImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}
