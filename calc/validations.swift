
//
//  validations.swift
//  calc
//
//  Created by user150278 on 3/27/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

class Validations {
    let op = "+-x/%"
    
    
    func isInteger(argument: String) -> Bool {
        if Int(argument) != nil {
            return true
        }
        return false
    }
    func hasOperation(arguments: Array<String>) -> Bool {
        for i in 0...arguments.count - 1 {
            if op.contains(arguments[i]) {
                return true
            }
        }
        
        let first = arguments[0]
        if isInteger(argument: first) && arguments.count == 1 { // If only one integer and no operations
            let new = first.replacingOccurrences(of: "+", with: "")
            print(new)
            exit(0)
        }
        return false
    }
    
    func unvalidInput(arguments: Array<String>) -> Bool {
        for i in 0...arguments.count-1 {
            if !isInteger(argument: arguments[i]) && !op.contains(arguments[i]) {//If not integer and not a valid operation
                    return true
            }
        }
        return false
    }
    
    func validArgumentOrder(arguments: Array<String>) -> Bool {
        var valid: Bool = false
        for i in 0...arguments.count-1 {
            // If the argument start and end with integers
            if Int(arguments[0]) != nil && Int(arguments[arguments.count-1]) != nil {
                // If even position is number, uneven positions is not number
                if i % 2 == 0 && Int(arguments[i]) != nil || !(i % 2 == 0) && !isInteger(argument: arguments[i]) {
                    valid = true
                }
                else {
                    valid = false
                }
            }
            else {
                valid = false
            }
        }
        return valid
    }
    
    func isValid(arguments: Array<String>) -> Bool {
        if validArgumentOrder(arguments: arguments) && !unvalidInput(arguments: arguments) && hasOperation(arguments: arguments) {
           return true
        }
        else {
            return false
        }
    }
}

