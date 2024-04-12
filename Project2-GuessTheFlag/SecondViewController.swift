//
//  SecondViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Matteo Orru on 07/04/24.
//

import UIKit

class SecondViewController: UIViewController {
        
    var highScore = 0
    
    var leaderBoard: UILabel!
    var highScoreLabel: UILabel!
    var secondScore: UILabel!
    var thirdScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupUI()
    }
    
    
    func setupUI() {
        //background
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appBG2.png")
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        //leaderboard label
        leaderBoard = UILabel()
        leaderBoard.translatesAutoresizingMaskIntoConstraints = false
        leaderBoard.text = "LEADERBOARD"
        leaderBoard.font = UIFont(name: "Supercell-Magic", size: 15.0)
        leaderBoard.textColor = UIColor(red: 254/255, green: 253/255, blue: 212/255, alpha: 1)
        leaderBoard.shadowColor = UIColor(red: 127/255, green: 54/255, blue: 19/255, alpha: 1)
        leaderBoard.shadowOffset = CGSize(width: 0, height: 3)
        
        //highestScore Label
        highScoreLabel = UILabel()
        highScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        highScoreLabel.text = "Highest score: \(highScore)"
        highScoreLabel.font = UIFont(name: "Supercell-Magic", size: 15.0)
        highScoreLabel.textColor = UIColor(red: 254/255, green: 253/255, blue: 212/255, alpha: 1)
        highScoreLabel.shadowColor = UIColor(red: 127/255, green: 54/255, blue: 19/255, alpha: 1)
        highScoreLabel.shadowOffset = CGSize(width: 0, height: 3)
        
        view.addSubview(leaderBoard)
        view.addSubview(highScoreLabel)
        
        
        NSLayoutConstraint.activate([
            leaderBoard.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            leaderBoard.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            highScoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 110),
            highScoreLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
        ])
    }
    

    
}
