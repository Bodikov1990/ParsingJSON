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
            avatarImageView.contentMode = .scaleAspectFit
            avatarImageView.clipsToBounds = true
            avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        }
    }
    
    
    
    func configure(from person: Person) {
        fullNameLabel.text = person.fullName
        
        NetworkManager.shared.getImage(from: person.image ?? "") { result in
            switch result {
            case .success(let imageData):
                self.avatarImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}
