//
//  Regex.swift
//  h_task
//
//  Created by MaxOS on 09.01.2024.
//

import Foundation


enum Regex : String {
    
    case phone = "(\\s*)?(\\+)?([- _():=+]?\\d[- _():=+]?){10,14}(\\s*)?"
    case email =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
}
