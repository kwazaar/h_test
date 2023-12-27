//
//  ImageCachingService.swift
//  h_task
//
//  Created by MaxOS on 26.12.2023.
//

import Foundation
import SwiftUI

class ImageCachingService: ObservableObject {
    @Published var image: UIImage?
      
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            self.image = UIImage(data: cachedResponse.data)
            completion(self.image)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let cacheData = CachedURLResponse(response: response!, data: data)
            URLCache.shared.storeCachedResponse(cacheData, for: request)
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                completion(self.image)
            }
        }.resume()
    }
}
