//
//  NetworkManager.swift
//  ParsingJSON
//
//  Created by Kuat Bodikov on 15.01.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case mainUrl = "https://my.api.mockaroo.com/fio.json?key=b2b55890"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    
    //    MARK: - Alamofire
    
    func fetchData(_ url: String, completion: @escaping(Result<[Person], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let persons = Person.getPersons(from: value)
                    completion(.success(persons))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func getImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        AF.download(url)
            .validate()
            .responseData { response in
                switch response.result {
                    
                case .success(let value):
                    completion(.success(value))
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    }
}


