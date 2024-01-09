//
//  BookingModel.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import Foundation


struct Booking: Identifiable, Codable {
    
    var id: Int
    var hotel_name: String
    var hotel_adress: String
    var horating: Int
    var rating_name: String
    var departure: String
    var arrival_country: String
    var tour_date_start: String
    var tour_date_stop: String
    var number_of_nights: Int
    var room: String
    var nutrition: String
    var tour_price: Int
    var fuel_charge: Int
    var service_charge: Int
    
}
