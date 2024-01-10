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
        VStack {
            ZStack() {
                Button {
                    coordinator.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                Text("Номер")
                    
            }
            
            .font(.headline)
            Spacer()
            HStack {
                VStack(alignment: .center) {
                    Image("Image", bundle: .none)
                        .resizable()
                        .frame(width: 94, height: 94, alignment: .center)
                    Text("Ваш заказ принят в работу")
                        .padding(.top, 25)
                        .padding(.bottom , 10)
                    Text("Подтверждение заказа №\(Int.random(in: 0...1000)) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                        .frame(width: 329, alignment: .center)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                }
            }
            Spacer()
            Button(action: {
                coordinator.popToRoot()
            }, label: {
                Text("Супер!")
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(15)
            })
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ConfirmView()
}
