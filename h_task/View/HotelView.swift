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
        VStack  {
            VStack {
                ImageView(spacing: 20, index: $currentIndex, items: viewModel.images) { image in
                    GeometryReader(content: { geometry in
                        let size = geometry.size
                        Image(uiImage: image.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    })
                }
                VStack(alignment: .leading) {
                    ZStack{
                        Rectangle()
                            .frame(width: 149, height: 29)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(Color(UIColor(named: "ratingBackground")!))
                            .opacity(0.2)
                        HStack(alignment: .center) {
                            Image(systemName: "star.fill")
                            Text("\(viewModel.hotel.rating) \(viewModel.hotel.rating_name)")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(Color(UIColor(named: "ratingTitle")!))
                        
                    }
                    Text(viewModel.hotel.name)
                        .font(.system(size: 22))
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
                }.padding()
                
            }
            
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
