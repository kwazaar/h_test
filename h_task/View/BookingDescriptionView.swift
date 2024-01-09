//
//  BookingDescriptionView.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import SwiftUI

struct BookingDescriptionView: View {
    
    var bookingModel: Booking
    
    init(bookingModel: Booking) {
        self.bookingModel = bookingModel
    }
    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: 140), alignment: .leading),
    GridItem(.flexible(minimum: 0, maximum: 250), alignment: .leading)]
    private var textColor = Color(red: 0.51, green: 0.53, blue: 0.59)
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: .sectionFooters) {
            Section {
                Text("Вылет из")
                    .foregroundColor(textColor)
                Text(bookingModel.departure)
            }
            Section {
                Text("Страна, город")
                    .foregroundColor(textColor)
                Text(bookingModel.arrival_country)
            }
            Section {
                Text("Даты")
                    .foregroundColor(textColor)
                Text("\(bookingModel.tour_date_start) – \(bookingModel.tour_date_stop)")
            }
            Section {
                Text("Кол-во ночей")
                    .foregroundColor(textColor)
                Text("\(bookingModel.number_of_nights)")
            }
            Section {
                Text("Отель")
                    .foregroundColor(textColor)
                Text(bookingModel.hotel_name)
            }
            Section {
                Text("Комната")
                    .foregroundColor(textColor)
                Text(bookingModel.room)
            }
            Section {
                Text("Питание")
                    .foregroundColor(textColor)
                Text(bookingModel.nutrition)
            }
        }
        .font(.system(size: 16))
    }
}

#Preview {
    BookingView()
}
