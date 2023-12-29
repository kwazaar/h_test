//
//  CellPeculiarities.swift
//  h_task
//
//  Created by MaxOS on 29.12.2023.
//

import SwiftUI

struct CellPeculiarities: View {
    
    var list: [String]
    
    init(list: [String]) {
        
        self.list = list
        
    }
    
    var body: some View {
        
        WrappingHStack(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 5) {
            ForEach(list, id: \.self) { item in
                Text(item)
                    .padding(5)
                    .foregroundColor(Color(red: 0.52, green: 0.52, blue: 0.59))
                    .background(Color(red: 0.98, green: 0.98, blue: 0.98, opacity: 1))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

#Preview {
    HotelView()
}
