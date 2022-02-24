//
//  DataAllGuys.swift
//  HomeWork12
//
//  Created by Yura on 17.12.2021.
//

import Foundation

class DataAllGuys {
    
    static var currentGuy: Guy? = nil
    private static var listOfGuys: [Guy] = []
    
    static var count: Int {
        get {
            return listOfGuys.count
        }
    }
    
    static func append(_ g: Guy) {
        listOfGuys.append(g)
    }
    
    static subscript(i: Int) -> Guy {
        get {
            return listOfGuys[i]
        }
        set {
            listOfGuys[i] = newValue
        }
    }
}
