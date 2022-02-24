//
//  JsonLoader.swift
//  HomeWork12
//
//  Created by Yura on 17.12.2021.
//

import Foundation

class JsonLoader {
    
    static func loadInfo(callback: @escaping () -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let ddata = data,
               let json = try? JSONSerialization.jsonObject(with: ddata, options: .allowFragments),
               let dict = json as? NSDictionary {
                
                if let results = dict["results"], let rresults = results as? NSArray {
                    for guy in rresults {
                        if let guyDict = guy as? NSDictionary,
                           let guyName = guyDict["name"] as? String,
                           let guyStatus = guyDict["status"] as? String,
                           let guyRace = guyDict["species"] as? String,
                           let guyLastLocDict = guyDict["location"] as? NSDictionary,
                           let guyLastLoc = guyLastLocDict["name"] as? String,
                           let imageString = guyDict["image"] as? String,
                           let id = guyDict["id"] as? Int {
                            
                            let imageUrl = URL(string: imageString)
                            let newGuy = Guy(id: id,
                                             name: guyName,
                                             isAlive: guyStatus == "Alive",
                                             race: guyRace,
                                             lastLocation: guyLastLoc,
                                             imageUrl: imageUrl!)
                                            
                            DataAllGuys.append(newGuy)
                        }
                    }
                }
            }
            callback()
        }
        task.resume()
    }
    
    static func loadInfo(by id: Int, callback: @escaping () -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let ddata = data,
               let json = try? JSONSerialization.jsonObject(with: ddata, options: .allowFragments),
               let dict = json as? NSDictionary {
                if let status = dict["status"] as? String,
                   let name = dict["name"] as? String,
                   let race = dict["species"] as? String,
                   let gender = dict["gender"] as? String,
                   let lastLocDict = dict["location"] as? NSDictionary,
                   let lastLoc = lastLocDict["name"] as? String,
                   let episodesUrlArr = dict["episode"] as? NSArray,
                   let imageString = dict["image"] as? String {
                    
                    
                    let imageUrl = URL(string: imageString)
                    var newGuy = Guy(id: 0, name: name, isAlive: status == "Alive", race: race, lastLocation: lastLoc, imageUrl: imageUrl!)
                    newGuy.gender = gender
                    DataAllGuys.currentGuy = newGuy
                    
                    
                    for i in episodesUrlArr {
                        if let ii = i as? String {
                            let url = URL(string: ii)
                            let request = URLRequest(url: url!)
                            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                if let ddata = data,
                                    let json = try? JSONSerialization.jsonObject(with: ddata, options: .allowFragments),
                                   let dict = json as? NSDictionary {
                                    if let nameEp = dict["name"] as? String,
                                       let epCode = dict["episode"] as? String {
                                        DataAllGuys.currentGuy!.episodesInfo.append(Episode(name: nameEp, episodeCode: epCode))
                                    }
                                }
                                callback()
                            }
                            task.resume()
                        }
                    }
                }
            }
        }
        task.resume()
        
    }
}
