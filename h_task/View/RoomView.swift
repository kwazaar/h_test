//
//  RoomView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct RoomView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        Button(action: {
            coordinator.push(.booking)
        }, label: {
            Text("Экран бронирования")
        })
    }
}

#Preview {
    RoomView()
}
