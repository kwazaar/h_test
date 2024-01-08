//
//  RoomViewModel.swift
//  h_task
//
//  Created by MaxOS on 30.12.2023.
//

import Foundation
import SwiftUI


struct Room: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var price: Int
    var price_per: String
    var peculiarities: [String]
    var image_urls: [String]
}

struct HotelData: Codable, Hashable {
    var rooms: [Room]
}

