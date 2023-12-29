//
//  CellHotelAbout.swift
//  h_task
//
//  Created by MaxOS on 29.12.2023.
//

import SwiftUI
struct CellHotelAbout : View {
    
    
    var icon: [String]
    var title: [String]
    
    init(icon: [String], title: [String]){
        self.icon = icon
        self.title = title
    }
    
    var body: some View {
            LazyVStack {
                ForEach(title.indices, id: \.self) { index in
                    
                    HStack {
                        Image(uiImage: UIImage(named: icon[index])!)
                            .resizable()
                            .frame(width: 24, height: 24)
                        VStack(alignment: .leading) {
                            Text(title[index])
                                .font(.system(size: 16, weight: .medium))
                            Text("Самое необходимое")
                                .foregroundColor(Color(red: 0.52, green: 0.52, blue: 0.59))
                                .font(.system(size: 14))
                        }
                        .font(.system(size: 16))
                        Spacer()
                        Image(uiImage: UIImage(named: "arrowNext")!)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
        }
        .padding(.horizontal)
        .frame(height: 170)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98, opacity: 1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    HotelView()
}


