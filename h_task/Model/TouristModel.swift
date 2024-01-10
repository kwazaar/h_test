//
//  TouristModel.swift
//  h_task
//
//  Created by MaxOS on 10.01.2024.
//

import Foundation


struct Tourist: Identifiable {
    var id = UUID()
    var name: String
    var lastName: String
    var birthday: String
    var nationality: String
    var numberPassport: String
    var validityPeriodPassport: String
}
