//
//  BookingDescriptionView.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import SwiftUI

struct PriceView: View {
    
    var bookingModel: Booking
    
    init(bookingModel: Booking) {
        self.bookingModel = bookingModel
    }
    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: 140), alignment: .leading),
    GridItem(.flexible(minimum: 0, maximum: 250), alignment: .trailing)]
    private var textColor = Color(red: 0.51, green: 0.53, blue: 0.59)
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: 16, pinnedViews: .sectionFooters) {
            Section {
                Text("Тур")
                    .foregroundColor(textColor)
                Text("\(bookingModel.tour_price)")
            }
            Section {
                Text("Топливный сбор")
                    .foregroundColor(textColor)
                Text("\(bookingModel.fuel_charge)")
            }
            Section {
                Text("Сервисный сбор")
                    .foregroundColor(textColor)
                Text("\(bookingModel.service_charge)" )
            }
            Section {
                Text("К оплате")
                    .foregroundColor(textColor)
                Text("\(bookingModel.tour_price + bookingModel.fuel_charge + bookingModel.service_charge)")
            }
        }
        .font(.system(size: 16))
    }
}

#Preview {
    BookingView()
}
