//
//  ContentView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI


struct HotelView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = HotelViewModel()
    @State var hotelInfo: Hotel?
    
    var body: some View {
        VStack  {
            ScrollView(.horizontal) {
                LazyVStack() {
                    ForEach(hotelInfo?.image_urls ?? [], id: \.self) { stringURL in
                        if let url = URL(string: stringURL) {
                            ImageView(imageURL: url)
                        }
                    }
                }
            }
            Spacer()
            Button(action: {
                coordinator.push(.room)
            }, label: {
                Text("К выбору номера")
            })
            .onAppear {
                NetworkService.shared.fetchData { result in
                    switch result {
                    case .success(let hotel):
                        self.hotelInfo = hotel
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
        }
        .navigationTitle("Отель")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    HotelView()
}
