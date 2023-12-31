//
//  RoomView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct RoomView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = RoomViewModel()
    @State var currentIndex: Int = 0
    var body: some View {
        ScrollView {
            
            ForEach(viewModel.hotelData.rooms) { room in
                Text(room.name)
            }
            Button(action: {
                coordinator.push(.booking)
            }, label: {
                Text("Экран бронирования")
            })
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    RoomView()
}
