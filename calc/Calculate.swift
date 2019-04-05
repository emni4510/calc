//
//  Calculate.swift
//  calc
//
//  Created by user150278 on 3/31/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation


/// This if the class that makes the calculation
class Calculate {
    
     /// An enum of operators valid in this project
     enum Operator: String {
        case plus = "+"
        case minus = "-"
        case mult = "x"
        case divide = "/"
        case mod = "%"
        
        static let validOperators = plus.rawValue + minus.rawValue + mult.rawValue + divide.rawValue + mod.rawValue
    }
   
    
    /// Gets the operators of the input arguments and returns them in an array
    ///
    /// - Parameter args: array of arguments
    /// - Returns: array of operators
    func getOperators(args : [String]) -> [String] {
        var operators = [String]()
        
        // Goes through all arguments, if not an integer appends to operator array
        for i in 0...args.count-1 {
            if !Validations.isInteger(argument: args[i]) {
                operators.append(args[i])
            }
        }
        return operators
    }

    
    /// Gets the integers of the input arguments and returns them in an array
    ///
    /// - Parameter args: array of arguments
    /// - Returns: array of integers
    func getIntegers(args : [String]) -> [Int] {
        var integers = [Int]()
        
        for i in 0...args.count-1 {
            if Validations.isInteger(argument: args[i]) {
                integers.append(Int(args[i])!)
            }
        }
        return integers
    }

    /// Solves to precedence. Calculates multiplications, divisions and modulus in the expression and returns
    /// new expression with only additions and subtractions.
    ///
    /// - Parameter args: array of arguments
    /// - Returns: array of arguments containing no multiplication, divisions or modulus
    func solvePrecedence(args : [String]) -> [String] {
        var newExpression = args
        var newInt: Int = 0
        
        for i in 0...args.count-1 {
            /// If argument is multiplication, division or modulus
            if args[i].elementsEqual(Operator.mult.rawValue) || args[i].elementsEqual(Operator.divide.rawValue) || args[i].elementsEqual(Operator.mod.rawValue) {
                /// If argument is multiplication, multiply the number before the argument with the number after
                if args[i].elementsEqual(Operator.mult.rawValue) {
                    newInt = Int(args[i-1])! * Int(args[i+1])!
                }
                /// If arguments is division or modulus, exit program and print error message if next integer is zero. Otherwise make calculations
                if args[i].elementsEqual(Operator.divide.rawValue) || args[i].elementsEqual(Operator.mod.rawValue){
                    if Int(args[i+1]) == 0 {
                        print("Error: Cannot divide by zero")
                        exit(1)
                    }
                    else {
                        if args[i].elementsEqual(Operator.mod.rawValue) {
                            newInt = Int(args[i-1])! % Int(args[i+1])!
                        }
                        else {
                            newInt = Int(args[i-1])! / Int(args[i+1])!
                        }
                    }
                }
    
                /// Remove calculated expression and insert the result to the new expression
                newExpression.remove(at: i-1)
                newExpression.remove(at: i-1)
                newExpression.remove(at: i-1)
                newExpression.insert(String(newInt), at: i-1)
                /// Pass the new expression to the same function again
                newExpression = solvePrecedence(args: newExpression)
                break
            }
        }
        
        return newExpression
    }

    
    /// Calculates the input expression and returns the result
    ///
    /// - Parameter args: array of arguments
    /// - Returns: the integer of the result
    func calculate(args : [String]) -> Int {
        /// Gets expression expressed in only additions and subtractions
        let expression = solvePrecedence(args: args)
        var integers = getIntegers(args: expression)
        var operators = getOperators(args: expression)
        var result: Int = integers[0]
        
       if (operators.isEmpty) {
            return result
        }
        
        // Goes through expression and solves additions and subtractions
        for i in 1...integers.count-1 {
            let op = operators[i-1]
            let nextInt = integers[i]
            
            if op.elementsEqual(Operator.plus.rawValue) {
                result += nextInt
            }
            else if op.elementsEqual(Operator.minus.rawValue) {
                result -= nextInt
            }
        }
        return result
    }

}
