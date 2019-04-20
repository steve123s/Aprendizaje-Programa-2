//
//  ViewController.swift
//  ReconocedorDeCaracteres
//
//  Created by Daniel Salinas on 4/19/19.
//  Copyright © 2019 DanielSteven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        runNeuralNetwork()
    }
    
    func runNeuralNetwork() {
        let data = CSVProcessor()
        
        let nn = DeepNeuralNetwork(iterations: 50, learningRate: 0.100)
        nn.add(layer: Layer.input(size: 42))
        nn.add(layer: Layer.fullyConnected(size: 8, activation: .relu))
        nn.add(layer: Layer.fullyConnected(size: 1, activation: .sigmoid))
        nn.compile()
        
        nn.fit(X: data.XTrain, y: data.yTrain)
        nn.test(X: data.XTest, y: data.yTest)
    }
}

