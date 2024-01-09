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
    
    @Published var hotel = Hotel(id: 0, name: "", adress: "", minimal_price: 0, price_for_it: "", rating: 5, rating_name: "", image_urls: [], about_the_hotel: AboutTheHotel(description: "", peculiarities: []))
    @Published var images: [ImageModel] = []
    @Published var icon = ["emoji", "tickSquare", "closeSquare"]
    @Published var title = ["Удобства", "Что включено", "Что не включено"]
    
    func loadData() {
        NetworkService.shared.fetchData(from: .hotel, responseType: Hotel.self) { result in
            switch result {
            case .success(let data):
                self.hotel = data
                for stringURL in data.image_urls {
                    
                    let imageCachingService = ImageCachingService()
                    imageCachingService.loadImage(from: URL(string: stringURL)!) { uiImage in
                        if let uiImage = uiImage {
                            self.images.append(ImageModel(roomID: 0, image: uiImage))
                        }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
