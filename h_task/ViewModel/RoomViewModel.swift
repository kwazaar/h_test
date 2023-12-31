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
    @Published var cellRoom: [CellRoom] = []
    var stringURL: [String] = []
    private var apiURL = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    
    func loadData() {
        NetworkService.shared.fetchData(from: apiURL, responseType: HotelData.self) { result in
            switch result {
            case .success(let data):
                self.hotelData = data
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        for room in hotelData.rooms {
            images = []
            for stringURL in room.image_urls {
                let imageCachingService = ImageCachingService()
                imageCachingService.loadImage(from: URL(string: stringURL)!) { uiImage in
                    if let uiImage = uiImage {
                        self.images.append(ImageModel(image: uiImage))
                    }
                }
            }
            cellRoom.append(CellRoom(id: room.id, images: images))
        }
    }
    
    
}
