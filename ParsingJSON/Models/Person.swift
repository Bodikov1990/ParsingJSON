//
//  Person.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 14.01.2022.
//


// MARK: - PersonElement
struct Person: Decodable {
    let first_name: String?
    let last_name: String?
    let email: String?
    let city: String?
    let image: String?
    var fullName: String {
        "\(first_name ?? "") \(last_name ?? "")"
    }
    
    var details: String {
        """
        \(fullName)
        \(email ?? "")
        \(city ?? "")

        """
    }
}
