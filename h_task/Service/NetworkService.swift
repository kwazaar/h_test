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
    
    func fetchData(completion: @escaping (Result<Hotel, Error>) -> ()) {
        if let url = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") {
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                let data = try! JSONDecoder().decode(Hotel.self, from: data!)
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
