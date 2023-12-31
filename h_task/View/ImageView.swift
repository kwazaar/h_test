//
//  ImageStackView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct ImageView<Content: View, T:Identifiable> : View {
    
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 20, trailingSpace: CGFloat = 20, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
                let width = (proxy.size.width - trailingSpace - spacing)
                HStack(spacing: spacing){
                    ForEach(list) { item in
                        content(item)
                            .frame(width: width)
                    }
                }
                .padding(.horizontal, spacing)
                .offset(x:(CGFloat(currentIndex) * -width) + offset - CGFloat(currentIndex * 20))
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            currentIndex = index
                        })
                        .onChanged({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                    
                )
            }
            .animation(.easeInOut, value: offset == 0)
            ZStack {
                Rectangle()
                    .frame(width: CGFloat(20 * list.count) , height: 25)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                HStack {
                    
                    ForEach(list.indices, id: \.self) { index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                            .frame(width: 5, height: 5)
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    HotelView()
}
