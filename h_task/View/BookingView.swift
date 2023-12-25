//
//  BookingView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct BookingView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        Button(action: {
            coordinator.push(.confirmScreen)
        }, label: {
            Text("Забронировать")
        })
    }
}

#Preview {
    BookingView()
}
