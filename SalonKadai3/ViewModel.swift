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
    static let displayResult = Self.init("displayResult")
}

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

final class ViewModel {
    
    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol
    
    init(notificationCenter: NotificationCenter,  model: ModelProtocol = Model()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    func NumbersInput(text: String?, isOn: Bool, textState: TextState) {
        let result = model.validate(text: text, isOn: isOn)
        
        switch result {
        case .success(let number):
            notificationCenter.post(name: textState.notificationName,
                                    object: number)
        case .failure(let error):
            notificationCenter.post(name: textState.notificationName,
                                    object: error.errorText)
        }
    }
    
    func calculate(firstLabel: String?, secondLabel: String?) {
        let result = model.calculate(firstLabel: firstLabel, secondLabel: secondLabel)
        
        switch result {
        case .success(let result):
            print(result)
            notificationCenter.post(name: .displayResult, object: result)
        case .failure(let error):
            notificationCenter.post(name: .displayResult, object: error.errorText)
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

private extension CalculateError {
    var errorText: String {
        switch self {
        case .calculateFailure:
            return "計算できません"
        }
    }
}
