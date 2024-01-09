//
//  BookingViewModel.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import Foundation
import SwiftUI
import Combine



class BookingViewModel: ObservableObject {
    @Published var bookingData: Booking?
    
    @Published var email: String = ""
    @Published var phone: String = "+7"
    @Published var canSubmit = false
    
    var emailPrompt: String? {
        if email.isEmpty || isValidEmail == true {
            return nil
        } else {
            return "Введите почту в формате: mail@mail.ru"
        }
    }
    var phonePrompt: String? {
        if phone == "+7" || isValidPhone == true {
            return nil
        } else {
            return "Введите корректный номер телефона"
        }
    }
    
    @Published private var isValidEmail = false
    @Published private var isValidPhone = false
    
    
    private let emailPredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    private let phonePredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellable)
        $phone
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { phone in
                return self.phonePredicate.evaluate(with: phone)
            }
            .assign(to: \.isValidPhone, on: self)
            .store(in: &cancellable)
        Publishers.CombineLatest($isValidEmail, $isValidPhone)
            .map { email, phone in
                return (email && phone)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellable)
    }
    
    func loadData() {
        NetworkService.shared.fetchData(from: .booking, responseType: Booking.self) { result in
            switch result {
            case .success(let data):
                self.bookingData = data
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
