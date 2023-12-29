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
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        VStack{
            ScrollView {
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack() {
                        ImageView(index: $currentIndex, items: viewModel.images) { image in
                            GeometryReader { geometry in
                                let size = geometry.size
                                Image(uiImage: image.image)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: size.width)
                                
                            }
                        }
                        .frame(height: 257)
                        VStack(alignment: .leading) {
                            ZStack{
                                Rectangle()
                                    .frame(width: 149, height: 29)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .foregroundColor(Color(red: 1, green: 0.780, blue: 0))
                                    .opacity(0.2)
                                HStack(alignment: .center) {
                                    Image(systemName: "star.fill")
                                    Text("\(viewModel.hotel.rating) \(viewModel.hotel.rating_name)")
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .foregroundColor(Color(red: 1, green: 0.659, blue: 0))
                                
                            }
                            Text(viewModel.hotel.name)
                                .font(.system(size: 22))
                                .lineLimit(2)
                            Text(viewModel.hotel.adress)
                                .font(.system(size: 14))
                                .foregroundStyle(.blue)
                            HStack {
                                Text("от \(viewModel.hotel.minimal_price) ₽")
                                    .font(.system(size: 30))
                                    .bold()
                                Text(viewModel.hotel.price_for_it)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                    }
                }
                VStack {
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        VStack(alignment: .leading) {
                            Text("Об отеле")
                                .font(.system(size: 22, weight: .medium))
                            CellPeculiarities(list: viewModel.hotel.about_the_hotel.peculiarities)
                            Text(viewModel.hotel.about_the_hotel.description)
                            CellHotelAbout(icon: viewModel.icon, title: viewModel.title)
                        }
                        .padding()
                    }
                }
                
            }
            .background(Color(.systemGroupedBackground))
            
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
            .cornerRadius(30)
        }
        
        .navigationTitle("Отель")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    HotelView()
}
