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

var mexValues = [Int: Int]()
var mySet = Set<Int>()
var globalSet = Set<Int>()


if input == nil {
    print("Type Int value")
}else {
    _ = mainCalculation(num: [input!])
    print(calculateMex(for: globalSet) == 0 ? 0 : calculateMex(for: globalSet) - 1)
}


func mainCalculation(num: [Int]) -> Int {
    if num.count == 1 {
        let n = num[0]
        switch n {
        case 0:
            mexValues[0] = 0
            mySet.insert(0)
            return 0
        case 1:
            mexValues[1] = 0
            mySet.insert(0)
            return 0
        case 2:
            mexValues[2] = 0
            mySet.insert(0)
            return 0
        default:
            break
        }
        
        let first = n - 1
        if first > 0 {
            if let mex = mexValues[first] {
                mySet.insert(mex)
            }else {
                for i in 0 ..< first / 2 {
                    mySet.insert(mainCalculation(num: [i+1, first-(i+1)]))
                }
            }
        }
        
        
        
        let second = n - 2
        if second > 0 {
            if let mex = mexValues[second] {
                mySet.insert(mex)
            }else {
                for i in 0 ..< second / 2 {
                    mySet.insert(mainCalculation(num: [i+1, second-(i+1)]))
                }
                let res = mainCalculation(num: [second])
                mySet.insert(res)
                mexValues[second] = res
            }
        }
        
        
        
        let third = n - 3
        if third >= 0 {
            if let mex = mexValues[third] {
                mySet.insert(mex)
            }else {
                for i in 0 ..< third / 2 {
                    mySet.insert(mainCalculation(num: [i+1, third-(i+1)]))
                }
            }
            
        }
    }else {
        let n1 = num[0]
        let n2 = num[1]
        
        let res = xor(
            first: mainCalculation(num: [n1]),
            second: mainCalculation(num: [n2])
        )
        mySet = Set()
        globalSet.insert(res)
        return res
    }
    globalSet.insert(calculateMex(for: mySet))
    return calculateMex(for: mySet)
}



func xor(first: Int, second: Int) -> Int {
    return first == second ? 0 : 1
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
