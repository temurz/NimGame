//
//  main.swift
//  NimGame
//
//  Created by Temur on 15/05/2024.
//

import Foundation
//Rule for 0.465
//4 - 100 - two heaps only
//6 - 110 - two or one heap only
//5 - 101 - two heaps or empty heap
print("Print some integer value!")
let input = Int(readLine() ?? "")

var mexDictionary = [Int: Int]()

if input == nil {
    print("Type Int value")
}else {
    calculateWithIteration(for: input!)
}

func calculateWithIteration(for num: Int) {
    for i in 0 ... num {
        var newSet = Set<Int>()
        if i - 1 >= 2 {
            for j in 0 ..< (i-1)/2 {
                newSet.insert(
                    (mexDictionary[j+1] ?? 0)^(mexDictionary[i-2-j] ?? 0)
                )
            }
        }
        
        if i - 2 > 0 {
            newSet.insert(mexDictionary[i-2] ?? 0)
            if i - 2 >= 2 {
                for j in 0 ..< (i-2)/2 {
                    newSet.insert(
                        (mexDictionary[j+1] ?? 0)^(mexDictionary[i-3-j] ?? 0)
                    )
                }
            }
        }
        
        if i - 3 == 0 {
            newSet.insert(0)
        }
        
        if i - 3 >= 2 {
            for j in 0 ..< (i-3)/2 {
                newSet.insert(
                    (mexDictionary[j+1] ?? 0)^(mexDictionary[i-4-j] ?? 0)
                )
            }
        }
        mexDictionary[i] = calculateMex(for: newSet)
        print("\(i) mex is \(mexDictionary[i] ?? 0)")
    }
}

func calculateMex(for set: Set<Int>) -> Int {
    var counter = 0
    while true {
        if !set.contains(counter) {
            return counter
        }
        counter += 1
    }
    return counter
}
