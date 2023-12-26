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
    
    func loadData() {
        NetworkService.shared.fetchData { result in
            switch result {
            case .success(let data):
                self.hotel = data
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
