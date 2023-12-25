//
//  ConfirmView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct ConfirmView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        Button(action: {
            coordinator.popToRoot()
        }, label: {
            Text("Вернуться на главный экран")
        })
    }
}

#Preview {
    ConfirmView()
}
