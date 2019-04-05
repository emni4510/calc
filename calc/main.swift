//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/// This is the main function of the program. Gets the arguments, check if they are valid and makes calculations.
func main() {
    // Gets array of arguments
    var args = ProcessInfo.processInfo.arguments
    // Removes the name of the program
    args.removeFirst()
    
    let calculate : Calculate = Calculate()
    
    if Validations.isValid(arguments: args) {
        let result = calculate.calculate(args: args)
        print(result)
    }
    else {
        print("Unvalid input")
        exit(1)
    }
}

main()
