//
//  Person.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 14.01.2022.
//


// MARK: - PersonElement
struct Person: Decodable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let city: String?
    let image: String?
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    var details: String {
        """
        \(fullName)
        \(email ?? "")
        \(city ?? "")

        """
    }
    
    init(personData: [String: Any]) {
    firstName = personData["first_name"] as? String
    lastName =  personData["last_name"] as? String
    email = personData["email"] as? String
    city = personData["city"] as? String
    image = personData["image"] as? String

    }
    
//    Оставил для себя
    
//    static func getPersons(from value: Any) -> [Person] {
//        guard let personsData = value as? [[String: Any]] else { return [] }
//
//        var persons: [Person] = []
//
//        for personData in personsData {
//            let person = Person(personData: personData)
//            persons.append(person)
//        }
//        return persons
//    }
    
    static func getPersons(from value: Any) -> [Person] {
        guard let personsData = value as? [[String: Any]] else { return [] }
        return personsData.compactMap { Person(personData: $0)}
    }
    
}
