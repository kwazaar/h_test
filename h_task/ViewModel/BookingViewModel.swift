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
    @Published var calculatePrice: Int = 0
    @Published var firstTourist: Tourist = Tourist(name: "", lastName: "", birthday: "", nationality: "", numberPassport: "", validityPeriodPassport: "")
    @Published var anyTourists: [Tourist] = []
    @Published var titleList: [String] = ["Второй турист", "Третий турист", "Четвертый турист", "Пятый турист"]
    @State var isShowTouristInformation = true
    
    @Published var email: String = ""
    @Published var phone: String = "+7"
    @Published var canSubmit = false
    
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var birthday: String = ""
    @Published var nationality: String = ""
    @Published var numberPassport: String = ""
    @Published var validityPeriodPassport: String = ""
    
    var emailPrompt: String? {
        if email.isEmpty || isValidEmail == true {
            return nil
        } else {
            return PromptText.email.rawValue
        }
    }
    var phonePrompt: String? {
        if phone == "+7" || isValidPhone == true {
            return nil
        } else {
            return PromptText.phone.rawValue
        }
    }
    var namePrompt: String? {
        if isValidName {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    var lastNamePrompt: String? {
        if isValidLastName {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    var birthdayPrompt: String? {
        if isValidBirthday {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    var nationalityPrompt: String? {
        if isValidNationality {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    var numberPassportPrompt: String? {
        if isValidNumberPassport {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    var validityPeriodPassportPrompt: String? {
        if isValidValidityPeriodPassport {
            return nil
        } else {
            return PromptText.moreInformation.rawValue
        }
    }
    
    @Published private var isValidEmail = false
    @Published private var isValidPhone = false
    @Published private var isValidName = true
    @Published private var isValidLastName = true
    @Published private var isValidBirthday = true
    @Published private var isValidNationality = true
    @Published private var isValidNumberPassport = true
    @Published private var isValidValidityPeriodPassport = true
    
    
    private let emailPredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    private let phonePredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    
    private var cancellable: Set<AnyCancellable> = []
    
    enum PromptText: String {
        case email = "Введите почту в формате: mail@mail.ru"
        case phone = "Введите корректный номер телефона"
        case moreInformation = "Данное поле необходимо заполнить"
    }
    
    init() {
        $name
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidName, on: self)
            .store(in: &cancellable)
        $lastName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidLastName, on: self)
            .store(in: &cancellable)
        $birthday
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidBirthday, on: self)
            .store(in: &cancellable)
        $nationality
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidNationality, on: self)
            .store(in: &cancellable)
        $numberPassport
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidNumberPassport, on: self)
            .store(in: &cancellable)
        $validityPeriodPassport
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { textField in
                return !textField.isEmpty
            }
            .assign(to: \.isValidValidityPeriodPassport, on: self)
            .store(in: &cancellable)
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
                self.calculateAllPrice()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func addTourist() {
        anyTourists.append(Tourist(name: "", lastName: "", birthday: "", nationality: "", numberPassport: "", validityPeriodPassport: ""))
    }
    func calculateAllPrice() {
        if let data = bookingData {
            calculatePrice = data.fuel_charge + data.service_charge + data.tour_price
        }
    }
    
}
