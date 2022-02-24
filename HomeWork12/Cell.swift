//
//  Cell.swift
//  HomeWork12
//
//  Created by Yura on 17.12.2021.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var imgGuy: UIImageView!
    @IBOutlet weak var lblNameG: UILabel!
    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var lblStatusAndRace: UILabel!
    @IBOutlet weak var lblLastKnownLoc: UILabel!
    
    var isGreen: Bool = false {
        didSet {
            if isGreen {
                viewRound.layer.backgroundColor = UIColor.green.cgColor
            } else {
                viewRound.layer.backgroundColor = UIColor.red.cgColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewRound.layer.cornerRadius = viewRound.frame.width / 2
    }
    

    
}
