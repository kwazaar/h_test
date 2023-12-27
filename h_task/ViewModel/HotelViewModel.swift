//
//  HoutelViewModel.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import Foundation
import SwiftUI
import Combine

class HotelViewModel: ObservableObject {
    
    
    @Published var hotel: Hotel?
    @Published var images: [ImageModel] = []
    
    func loadData() {
        NetworkService.shared.fetchData { result in
            switch result {
            case .success(let data):
                self.hotel = data
                for stringURL in data.image_urls {
                    
                    let imageCachingService = ImageCachingService()
                    imageCachingService.loadImage(from: URL(string: stringURL)!) { uiImage in
                        if let uiImage = uiImage {
                            self.images.append(ImageModel(image: uiImage))
                        }
                    }
                    
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
