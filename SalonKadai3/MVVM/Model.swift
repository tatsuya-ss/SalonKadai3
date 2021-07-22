//
//  Model.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/15.
//

import Foundation

enum TextError: Error {
    case invalidNil
    case invalidEnpty
    case invalidNotInt
}

enum CalculateError: Error {
    case calculateFailure
}

protocol ModelProtocol {
    func validate(text: String?, isOn: Bool) -> Result<String, TextError>
    func calculate(firstLabel: String?, secondLabel: String?) -> Result<String, CalculateError>
}

final class Model: ModelProtocol {
    func validate(text: String?, isOn: Bool) -> Result<String, TextError> {
        switch text {
        case (.none): // nilかどうか検証
            return .failure(.invalidNil)
        case (let text?):
            switch text.isEmpty {  // nilじゃなければ、空かどうか検証
            case true:
                return .failure(.invalidEnpty)
            case false: // 空じゃなければ、文字列か数列かを検証
                if let numberInt = Int(text) {
                    switch isOn {
                    case true:
                        let minusNumber = -numberInt
                        return .success(String(minusNumber))
                    case false:
                        return .success(String(numberInt))
                    }
                } else {
                    return .failure(.invalidNotInt)
                }
            }
        }
    }
    
    func calculate(firstLabel: String?, secondLabel: String?) -> Result<String, CalculateError> {
        if let first = Int(firstLabel!),
           let second = Int(secondLabel!) {
            let resultInt = first + second
            let resultString = String(resultInt)
            return .success(resultString)
        } else {
            return .failure(.calculateFailure)
        }
    }
}
