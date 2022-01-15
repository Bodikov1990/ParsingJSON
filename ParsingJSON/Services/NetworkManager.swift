//
//  NetworkManager.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 15.01.2022.
//

import UIKit

class NetworkingManager {
    static var shared = NetworkingManager()
    private init() {}
    
    func fetchImage(url: String, complition: @escaping(_ image: UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                complition(image)
            }

        }.resume()
    }

}
