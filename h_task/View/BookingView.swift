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
    @State var isShowTouristInformation = true
    
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
                                .keyboardType(.numberPad)
                                .onChange(of: viewModel.phone) { newValue in
                                    DispatchQueue.main.async {
                                        viewModel.phone = viewModel.phone.formattedMask(text: viewModel.phone, mask: "+X (XXX) XXX-XX-XX")
                                    }
                                }
//
                            CustomTextField(title: "Почта", text: $viewModel.email, prompt: viewModel.emailPrompt)
                            Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        VStack {
                            HStack{
                                Text("Первый турист")
                                    .font(.title)
                                    Spacer()
                                Button(action: {
                                    isShowTouristInformation.toggle()
                                }, label: {
                                    if isShowTouristInformation {
                                        Image(systemName: "chevron.up")
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 8)
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(6.0)
                                    } else {
                                        Image(systemName: "chevron.down")
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 8)
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(6.0)
                                    }
                                })
                            }
                            if isShowTouristInformation {
                                CustomTextField(title: "Имя", text: $viewModel.name, prompt: viewModel.namePrompt)
                                CustomTextField(title: "Фамилия", text: $viewModel.lastName, prompt: viewModel.lastNamePrompt)
                                CustomTextField(title: "Дата рождения", text: $viewModel.birthday, prompt: viewModel.birthdayPrompt)
                                CustomTextField(title: "Гражданство", text: $viewModel.nationality, prompt: viewModel.nationalityPrompt)
                                CustomTextField(title: "Номер загранпаспорта", text: $viewModel.numberPassport, prompt: viewModel.numberPassportPrompt)
                                CustomTextField(title: "Срок действия загранпаспорта", text: $viewModel.validityPeriodPassport, prompt: viewModel.validityPeriodPassportPrompt)
                            }
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        LazyVStack {
                            ForEach(0..<viewModel.anyTourists.count, id: \.self) { index in
                                TouristInformationView(title: viewModel.titleList[index])
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(20)
                        }
                        HStack{
                            Text("Добавить туриста")
                                .font(.title)
                                Spacer()
                            Button(action: {
                                viewModel.addTourist()
                            }, label: {
                                    Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue)
                                    .cornerRadius(6.0)
                            })
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        PriceView(bookingModel: viewModel.bookingData!)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            Button(action: {
                if viewModel.canSubmit && !viewModel.email.isEmpty && !viewModel.phone.isEmpty && !viewModel.name.isEmpty && !viewModel.lastName.isEmpty && !viewModel.birthday.isEmpty && !viewModel.nationality.isEmpty && !viewModel.numberPassport.isEmpty && !viewModel.validityPeriodPassport.isEmpty  {
                    coordinator.push(.confirmScreen)
                }
            }, label: {
                Text("Оплатить \(viewModel.calculatePrice)₽")
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
