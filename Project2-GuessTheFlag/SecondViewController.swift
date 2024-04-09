//
//  SecondViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Matteo Orru on 07/04/24.
//

import UIKit

class SecondViewController: UIViewController {
        
    var currentScore = 0
    
    var leaderBoard: UILabel!
    var highScore: UILabel!
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
        highScore = UILabel()
        highScore.translatesAutoresizingMaskIntoConstraints = false
        highScore.text = "Highest score: \(currentScore)"
        highScore.font = UIFont(name: "Supercell-Magic", size: 15.0)
        highScore.textColor = UIColor(red: 254/255, green: 253/255, blue: 212/255, alpha: 1)
        highScore.shadowColor = UIColor(red: 127/255, green: 54/255, blue: 19/255, alpha: 1)
        highScore.shadowOffset = CGSize(width: 0, height: 3)
        
        view.addSubview(leaderBoard)
        view.addSubview(highScore)
        
        
        NSLayoutConstraint.activate([
            leaderBoard.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            leaderBoard.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            highScore.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 110),
            highScore.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
        ])
    }
    

    
}
