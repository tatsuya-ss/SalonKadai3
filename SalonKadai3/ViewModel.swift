//
//  ViewModel.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/15.
//

import Foundation

extension Notification.Name {
    static let inputFirstText = Self.init("inputFirstText")
    static let inputSecondText = Self.init("inputSecondText")
}



final class ViewModel {
    
    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol
    
    init(notificationCenter: NotificationCenter,  model: ModelProtocol = Model()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    func firstNumbersInput(firstText: String?) {
        let result = model.validate(text: firstText)
        
        switch result {
        case .success(let number):
            notificationCenter.post(name: .inputFirstText,
                                    object: number)
        case .failure(let error):
            notificationCenter.post(name: .inputFirstText,
                                    object: error.errorText)
        }
    }
    
    func secondNumbersInput(secondText: String?) {
        let result = model.validate(text: secondText)
        
        switch result {
        case .success(let number):
            notificationCenter.post(name: .inputSecondText,
                                    object: number)
        case .failure(let error):
            notificationCenter.post(name: .inputSecondText,
                                    object: error.errorText)
        }
    }
}

private extension TextError {
    var errorText: String {
        switch self {
        case .invalidNil:
            return "Nil"
        case .invalidEnpty:
            return "Enpty"
        case .invalidNotInt:
            return "NotInt"
        }
    }
}
