//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

let op: String = "+-*/%"


func getOperators(arguments: Array<String>) -> Array<String> {
    var operators = [String]()
    //let op: String = "+-*/%"
    for i in 0...arguments.count-1 {
        if op.contains(arguments[i]) {
            operators.append(arguments[i])
        }
    }
    return operators
}


func getIntegers(arguments: Array<String>) -> Array<Int> {
    var integers = [Int]()
    
    for i in 0...arguments.count-1 {
        let num = Int(arguments[i])
        if num != nil {
            integers.append(Int(arguments[i])!)
        }
    }
    return integers
}

func multdiv(arguments: Array<String>) -> Array<String> {
    var newExpression = arguments
    var newInt: Int = 0
    
    for i in 0...arguments.count-1 {
        if arguments[i].elementsEqual("x") || arguments[i].elementsEqual("/") {
            
            if arguments[i].elementsEqual("x") {
                newInt = Int(arguments[i-1])! * Int(arguments[i+1])!
            }
            if arguments[i].elementsEqual("/") {
                newInt = Int(arguments[i-1])! / Int(arguments[i+1])!
            }
            
            newExpression.remove(at: i-1)
            newExpression.remove(at: i-1)
            newExpression.remove(at: i-1)
            newExpression.insert(String(newInt), at: i-1)
            newExpression = multdiv(arguments: newExpression)
            break
        }
    }
    
    return newExpression
}

func calculate(arguments: Array<String>) -> Int {
    let expression = multdiv(arguments: arguments)
    var integers = getIntegers(arguments: expression)
    var operators = getOperators(arguments: expression)
   
    if(operators.isEmpty) {
        return integers[0]
    }
    var result: Int = integers[0]
    
    for i in 1...integers.count-1 {
        let op = operators[i-1]
        let nextInt = integers[i]
        
       
        if op.elementsEqual("+") {
            result += nextInt
        }
        else if op.elementsEqual("-") {
            result -= nextInt
        }
    }
    
    return result
}

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program
//var op = getOperators(arguments: args)
//var inte = getIntegers(arguments: args)
//print(Int(args[0])!)

//print(op)
//print(inte)
var result = calculate(arguments: args)
print(result)
