//
//  BookingView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct BookingView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = BookingViewModel()
    @State private var textColor = Color(red: 0.66, green: 0.67, blue: 0.72)
    
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
                Text("Бронирование")
            }
            .font(.headline)
            ScrollView {
                if !(viewModel.bookingData == nil) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Image(systemName: "star.fill")
                                Text("\(viewModel.bookingData!.horating) \(viewModel.bookingData!.rating_name)")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .padding(3)
                            .background(Color(red: 1, green: 0.780, blue: 0, opacity: 0.2))
                            .cornerRadius(5)
                            .foregroundColor(Color(red: 1, green: 0.780, blue: 0))
                            
                            Text(viewModel.bookingData!.hotel_name)
                                .font(.system(size: 22))
                                .lineLimit(2)
                            Button(viewModel.bookingData!.hotel_adress){ }
                                .font(.system(size: 14))
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .background(Color(.white))
                        .cornerRadius(20)
                        VStack(alignment: .leading) {
                            BookingDescriptionView(bookingModel: viewModel.bookingData!)
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        VStack(alignment: .leading) {
                            Text("Информация о покупателе")
                                .font(.system(size: 22))
                            CustomTextField(title: "Номер телефона", text: $viewModel.phone, prompt: viewModel.phonePrompt)
                                .onChange(of: viewModel.phone) { newValue in
                                    DispatchQueue.main.async {
                                        viewModel.phone = viewModel.phone.formattedMask(text: viewModel.phone, mask: "+X (XXX) XXX-XX-XX")
                                    }
                                }
                                .textContentType(.telephoneNumber)
                            CustomTextField(title: "Почта", text: $viewModel.email, prompt: viewModel.emailPrompt)
                            Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            Button(action: {
                if viewModel.canSubmit && !viewModel.email.isEmpty && !viewModel.phone.isEmpty {
                    coordinator.push(.confirmScreen)
                }
            }, label: {
                Text("Забронировать")
            })
            .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(15)
            .onAppear {
                viewModel.loadData()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    BookingView()
}
