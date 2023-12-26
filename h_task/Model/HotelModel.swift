//
//  HotelModel.swift
//  h_task
//
//  Created by MaxOS on 26.12.2023.
//

import Foundation
import SwiftUI


struct Hotel: Identifiable, Codable {
    var id: Int
    var name: String
    var adress: String
    var minimal_price: Int
    var price_for_it: String
    var rating: Int
    var rating_name: String
    var image_urls: [String]
    var about_the_hotel: AboutTheHotel
}

struct AboutTheHotel: Codable {
    var description: String
    var peculiarities: [String]
}
