//
//  NetworkService.swift
//  h_task
//
//  Created by MaxOS on 26.12.2023.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        if let url = URL(string: url) {
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                let data = try! JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    
}
