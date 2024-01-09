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
    
    enum APIURL: String {
        case hotel = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
        case room = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
        case booking = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    }
    
    func fetchData<T: Decodable>(from url: APIURL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        if let url = URL(string: url.rawValue) {
            
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
