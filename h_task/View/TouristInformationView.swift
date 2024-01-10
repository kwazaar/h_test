//
//  TouristInformationView.swift
//  h_task
//
//  Created by MaxOS on 10.01.2024.
//

import SwiftUI

struct TouristInformationView: View {
    
    
    var title: String
    @State var isShowTouristInformation = false
    @State var name: String = ""
    @State var lastName: String = ""
    @State var birthday: String = ""
    @State var nationality: String = ""
    @State var numberPassport: String = ""
    @State var validityPeriodPassport: String = ""
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            HStack{
                Text(title)
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
                CustomTextField(title: "Имя", text: $name)
                CustomTextField(title: "Фамилия", text: $lastName)
                CustomTextField(title: "Дата рождения", text: $birthday)
                CustomTextField(title: "Гражданство", text: $nationality)
                CustomTextField(title: "Номер загранпаспорта", text: $numberPassport)
                CustomTextField(title: "Срок действия загранпаспорта", text: $validityPeriodPassport)
            }
        }
    }
}

#Preview {
    BookingView()
}
