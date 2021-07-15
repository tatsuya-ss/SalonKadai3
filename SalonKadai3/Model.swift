//
//  Model.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/15.
//

import Foundation

enum TextError: Error {
    case invalidFirst
    case invalidSecond
    case invalidBoth
}

protocol ModelProtocol {
    func validate(firstText: String?, secontText: String?) -> Result<Void, TextError>
}

final class Model : ModelProtocol {
    func validate(firstText: String?, secontText: String?) -> Result<Void, TextError> {
        switch (firstText, secontText) {
        case (.none, .none):
            return .failure(.invalidBoth)
        case (.none, .some):
            return .failure(.invalidFirst)
        case (.some, .none):
            return .failure(.invalidSecond)
        case (let firstText?, let secondText?):
            switch (firstText.isEmpty, secondText.isEmpty) {
            case (true, true):
                return .failure(.invalidBoth)
            case (true, false):
                return .failure(.invalidFirst)
            case (false, true):
                return .failure(.invalidSecond)
            case (false, false):
                return .success(())
            }
        }
    }
    

    
    
}
