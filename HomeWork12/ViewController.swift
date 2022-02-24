//
//  ViewController.swift
//  HomeWork12
//
//  Created by Yura on 17.12.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataAllGuys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guy = DataAllGuys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.lblNameG.text = guy.name
        cell.lblStatusAndRace.text = (guy.isAlive ? "Alive" : "Dead") + " - \(guy.race)"
        cell.isGreen = guy.isAlive
        cell.lblLastKnownLoc.text = guy.lastLocation
        
        
        let request = URLRequest(url: guy.imageUrl)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let ddata = data,
               let image = UIImage(data: ddata) {
                DispatchQueue.main.async {
                    cell.imgGuy.image = image
                }
            }
        }
        task.resume()
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JsonLoader.loadInfo(callback: afterLoadInfo)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func afterLoadInfo() {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcDetail = segue.destination as? Detail_VC {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let id = DataAllGuys[indexPath.row].id
                vcDetail.id = id
            }
        }
    }
    
}

