//
//  CustomTextField.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    private var title: String
    private var text: Binding<String>
    private var prompt: String?
    var titleColor = Color(red: 0.66, green: 0.67, blue: 0.72)
    
    init(title: String, text: Binding<String>, prompt: String? = nil) {
        self.title = title
        self.text = text
        self.prompt = prompt
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 12))
                        .foregroundColor(titleColor)
                        .padding(.top, 10)
                    TextField("", text: text)
                        .font(.system(size: 16))
                        .padding(.bottom, 10)
                    }
                    .padding(.leading, 16)
            
                    .background(prompt == nil ? Color.gray.opacity(0.1) : Color.red.opacity(0.15))
                    .cornerRadius(10)
            if let prompt = prompt {
                Text(prompt)
                    .textFieldStyle(CustomTextFieldStyle())
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BookingView()
}
