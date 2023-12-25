//
//  Coordinator.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import Foundation
import SwiftUI

enum Page: String, Identifiable {
    
    var id: String {
        self.rawValue
    }
    
    case hotel, room, booking, confirmScreen
}
class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismiss(){
        //
    }
    
    @ViewBuilder
    func build(page: Page) -> some View{
        
        switch page {
        case .hotel:
            NavigationStack {
                HotelView()
            }
        case .room:
            RoomView()
        case .booking:
            BookingView()
        case .confirmScreen:
            ConfirmView()
        }
    }
    
}
