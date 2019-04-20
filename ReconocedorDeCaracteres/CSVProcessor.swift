//
//  CSVProcessor.swift
//  DeepNeuralNetworkDemo
//
//  Created by Jeremi Kaczmarczyk on 27/09/2017.
//  Copyright © 2017 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation
import Matswift

class CSVProcessor {
    
    let XTrain: Matrix
    let yTrain: Matrix
    
    let XTest: Matrix
    let yTest: Matrix
    
    init() {
        let path = Bundle.main.path(forResource: "numbers", ofType: "csv")
        let csv = try! String(contentsOfFile: path!)
        let array = csv.split(separator: "\n").map { $0.split(separator: ",") }
        
        var X = [[Double]]()
        var y = [[Double]]()
        
        for element in array.shuffled() {
            /*switch String(element[42]) {
            case "Uno":
                y.append([0.1])
            case "Dos":
                y.append([0.2])
            case "Tres":
                y.append([3.0])
            case "Cuatro":
                y.append([4.0])
            case "Cinco":
                y.append([5.0])
            case "Seis":
                y.append([6.0])
            case "Siete":
                y.append([7.0])
            case "Ocho":
                y.append([8.0])
            case "Nueve":
                y.append([9.0])
            default:
                break
            }*/
            y.append(String(element[42]) == "Nueve" ? [1.0] : [0.0])
            X.append(element[0...41].map { Double($0)! })
        }
        
        var max = X.flatMap { $0.max() }
        var min = X.flatMap { $0.min() }
        var newX = [[Double]]()
        for i in 0..<X.count {
            var newColumn = [Double]()
            for value in X[i] {
                let newValue = (value / min[i]) / (max[i] / min[i])
                newColumn.append(newValue)
            }
            newX.append(newColumn)
        }
        
        self.XTrain = Matrix(values: Array<[Double]>(newX[0...49])).T
        self.yTrain = Matrix(values: Array<[Double]>(y[0...49])).T
        
        self.XTest = Matrix(values: Array<[Double]>(newX[50...59])).T
        self.yTest = Matrix(values: Array<[Double]>(y[50...59])).T
    }
    
}

extension MutableCollection {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
