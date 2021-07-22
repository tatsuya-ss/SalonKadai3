//
//  TextFieldState.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/22.
//

import Foundation

enum TextState {
    case first
    case second

    var notificationName: Notification.Name {
        switch self {
        case .first:
            return .inputFirstText
        case .second:
            return .inputSecondText
        }
    }
}
