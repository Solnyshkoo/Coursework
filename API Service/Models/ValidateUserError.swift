//
//  ValidateUserError.swift
//  Coursework
//
//  Created by Ksenia Petrova on 27.04.2022.
//

import Foundation
enum ValidationError: LocalizedError {
    case noUser
    case wrongPassword
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .noUser:
            return "No such user"
        case .wrongPassword:
            return "The password is wrong"
        case .fatalEror:
            return "Please, try later"
        }
    }
}
