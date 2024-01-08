//
//  RoomViewModel.swift
//  h_task
//
//  Created by MaxOS on 30.12.2023.
//

import Foundation
import SwiftUI


class RoomViewModel: ObservableObject {
    
    @Published var hotelData = HotelData(rooms: [])
    @Published var images: [ImageModel] = []
    var stringURL: [String] = []
    private var apiURL = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    
    func loadData() {
        NetworkService.shared.fetchData(from: apiURL, responseType: HotelData.self) { result in
            switch result {
            case .success(let data):
                self.hotelData = data
                for roomIndex in 0..<data.rooms.count {
                    for stringURL in data.rooms[roomIndex].image_urls {
                        
                        let imageCachingService = ImageCachingService()
                        imageCachingService.loadImage(from: URL(string: stringURL)!) { uiImage in
                            if let uiImage = uiImage {
                                self.images.append(ImageModel(roomID: roomIndex, image: uiImage))
                            }
                        }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
