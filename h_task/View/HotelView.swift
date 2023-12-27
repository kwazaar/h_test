//
//  ContentView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI


struct HotelView: View {
    
    @ObservedObject var imageCachingService = ImageCachingService()
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = HotelViewModel()
    @State var hotelInfo: Hotel?
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        VStack  {
            ZStack {
                ImageView(spacing: 20, index: $currentIndex, items: viewModel.images) { image in
                    GeometryReader(content: { geometry in
                        let size = geometry.size
                        Image(uiImage: image.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 275)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    })
                }
                HStack {
                    
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                            .frame(width: 10, height: 10)
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 275)
            
            Spacer()
            Button(action: {
                coordinator.push(.room)
            }, label: {
                Text("К выбору номера")
            })
            .onAppear {
                viewModel.loadData()
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
