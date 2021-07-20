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

protocol ModelProtocol {
    func validate(text: String?, isOn: Bool) -> Result<String, TextError>
}

final class Model : ModelProtocol {
    func validate(text: String?, isOn: Bool) -> Result<String, TextError> {
        switch (text) {
        case (.none):
            return .failure(.invalidNil)
        case (let text?):
            switch text.isEmpty {
            case true:
                return .failure(.invalidEnpty)
            case false:
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
    

    
    
}
