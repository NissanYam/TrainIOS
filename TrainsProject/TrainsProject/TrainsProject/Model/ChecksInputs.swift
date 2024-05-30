//
//  ChecksInputs.swift
//  TrainTrack
//
//  Created by user262074 on 5/27/24.
//

import Foundation
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: email)
}
func isValidPassword(_ password: String) -> Bool {
    // Minimum length requirement for Firebase
    let minLength = 6
    
    // Check if the password meets the minimum length requirement
    if password.count < minLength {
        return false
    }
    
    return true
}
func checkValidDay(day: Int, month: Int, year: Int) -> Bool {
    // Check if the day is within the valid range for the given month and year
    switch month {
    case 1, 3, 5, 7, 8, 10, 12:
        return day >= 1 && day <= 31
    case 4, 6, 9, 11:
        return day >= 1 && day <= 30
    case 2:
        // Check for leap years if the month is February
        if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
            // Leap year
            return day >= 1 && day <= 29
        } else {
            // Non-leap year
            return day >= 1 && day <= 28
        }
    default:
        return false // Invalid month
    }
}
func checkValidHour(hour: Int, minutes: Int) -> Bool {
    // Check if the hour is within the valid range (0-23) and minutes are within the valid range (0-59)
    return (hour >= 0 && hour <= 23) && (minutes >= 0 && minutes <= 59)
}

