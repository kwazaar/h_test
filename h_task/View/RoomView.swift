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
    @State var roomIndex = 0
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
            ScrollView {
                
                ForEach (0..<viewModel.hotelData.rooms.count, id: \.self) { roomIndex in
                    VStack {
                        ImageView(index: $currentIndex, items: viewModel.images.filter { $0.roomID == roomIndex }) { image in
                            GeometryReader { geometry in
                                let size = geometry.size
                                Image(uiImage: image.image)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: size.width)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.width * 0.65)
                        VStack (alignment: .leading) {
                            Text(viewModel.hotelData.rooms[roomIndex].name)
                                .font(.system(size: 22, weight: .medium))
                            CellPeculiarities(list: viewModel.hotelData.rooms[roomIndex].peculiarities)
                            HStack(alignment: .center) {
                                
                                Text("Подробнее о номере")
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding(5)
                            .background(Color(red: 0.05, green: 0.45, blue: 1, opacity: 0.2))
                            .cornerRadius(5)
                            .foregroundColor(Color(red: 0, green: 0.45, blue: 1))
                            HStack(alignment: .bottom) {
                                Text("\(viewModel.hotelData.rooms[roomIndex].price) ₽")
                                    .font(.system(size: 30))
                                    .bold()
                                Text(viewModel.hotelData.rooms[roomIndex].price_per)
                                    .foregroundStyle(.gray)
                            }
                            Button(action: {
                                coordinator.push(.booking)
                            }, label: {
                                Text("Выбрать номер")
                            })
                            .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical)
                    .background(Color(.white))
                    .cornerRadius(20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .onAppear {
                viewModel.loadData()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RoomView()
}
