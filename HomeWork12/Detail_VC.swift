//
//  Detail_VC.swift
//  HomeWork12
//
//  Created by Yura on 23.12.2021.
//

import UIKit

class Detail_VC: UIViewController {
    
    var id: Int = 0

    @IBOutlet weak var imgGuy: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGreenLabel: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRaceAndGender: UILabel!
    @IBOutlet weak var lblLastLoc: UILabel!
    @IBOutlet weak var lblFirstEp: UILabel!
    @IBOutlet weak var lblAllEpizodes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblGreenLabel.layer.cornerRadius = lblGreenLabel.frame.width / 2
        
        JsonLoader.loadInfo(by: id, callback: afterInfoLoaded)
    }
    
    func afterInfoLoaded() {
        if let guy = DataAllGuys.currentGuy {
            loadGuyImg(url: guy.imageUrl)
            
            DispatchQueue.main.async {
                self.lblName.text = guy.name
                
                if guy.isAlive {
                    self.lblStatus.text = "Alive"
                    self.lblGreenLabel.layer.backgroundColor = UIColor.green.cgColor
                } else {
                    self.lblStatus.text = "Dead"
                    self.lblGreenLabel.layer.backgroundColor = UIColor.red.cgColor
                }
                
                self.lblLastLoc.text = guy.lastLocation
                self.lblRaceAndGender.text = "\(guy.race)(\(guy.gender))"
                self.lblFirstEp.text = guy.episodesInfo[0].name
                self.lblAllEpizodes.text = guy.stringAllEp()
            }
        }
    }
    
    func loadGuyImg(url: URL) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let ddata = data,
               let image = UIImage(data: ddata) {
                DispatchQueue.main.async {
                    self.imgGuy.image = image
                }
            }
        }
        task.resume()
    }
    
}
