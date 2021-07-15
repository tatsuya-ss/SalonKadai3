//
//  ViewModel.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/15.
//

import Foundation

final class ViewModel {
    
    private let model: ModelProtocol
    
    init(model: ModelProtocol = Model()) {
        self.model = model
    }
    
    func numbersInput(first: String?, second: String?) {
        let result = model.validate(firstText: first, secontText: second)
        
        
    }
}
