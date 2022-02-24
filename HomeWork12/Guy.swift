//
//  Guy.swift
//  HomeWork12
//
//  Created by Yura on 17.12.2021.
//

import Foundation

struct Guy {
    let id: Int
    let name: String
    let isAlive: Bool
    let race: String
    let lastLocation: String
    let imageUrl: URL
    
    var gender: String = ""
    var episodesInfo: [Episode] = []
    
    
    func stringAllEp() -> String {
        var result = ""
        
        if episodesInfo.count > 0 {
            for i in episodesInfo {
                if result != "" {
                    result += ", "
                }
                result += "\(i.name)(\(i.episodeCode))"
            }
            
        }
        return result
    }
}
