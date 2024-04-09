//
//  ViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Matteo Orru on 31/12/23.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var correctAnswerEffect: AVAudioPlayer?
    var wrongAnswertEffect: AVAudioPlayer?
    
    @IBOutlet var flagButton1: UIButton!
    @IBOutlet var flagButton2: UIButton!
    @IBOutlet var flagButton3: UIButton!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var leaderboardButton: UIButton!
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var countries = [String]()
    var currentScore = 0
    var correctAnswer = 0
    var isGameActive = false
    var isTimerActive = false
    var timer: Timer?
    var secondsRemaining = 30
    var isAlertPresented = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentScore = UserDefaults.standard.integer(forKey: "currentScore")
        
        saveScore()
        setupUI()
    }
    
    
    
    func setupUI() {
        headerLabel.text = "Guess the flag"
        scoreLabel.text = "Score: \(currentScore)"
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us", "argentina", "barbados", "brasil", "canada", "cuba", "cyprus", "hong kong", "kazakhstan", "norway", "south africa", "south korea", "swaziland", "tunisia", "zambia"]
        
        setupButtons()
        disableFlagButtons()
    }
    
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(currentScore)"
    }
    
    
    func setupButtons() {
        flagButton1.layer.borderWidth = 3.0
        flagButton2.layer.borderWidth = 3.0
        flagButton3.layer.borderWidth = 3.0
        
        flagButton1.layer.borderColor = UIColor.black.cgColor
        flagButton2.layer.borderColor = UIColor.black.cgColor
        flagButton3.layer.borderColor = UIColor.black.cgColor
        
        flagButton1.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        flagButton1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        flagButton1.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        flagButton1.layer.shadowOpacity = 10.0
        flagButton1.layer.shadowRadius = 10.0
        flagButton1.layer.masksToBounds = false
        
        flagButton2.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        flagButton2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        flagButton2.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        flagButton2.layer.shadowOpacity = 10.0
        flagButton2.layer.shadowRadius = 10.0
        flagButton2.layer.masksToBounds = false
        
        flagButton3.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        flagButton3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        flagButton3.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        flagButton3.layer.shadowOpacity = 10.0
        flagButton3.layer.shadowRadius = 10.0
        flagButton3.layer.masksToBounds = false
        
        restartButton.addTarget(self, action: #selector(button4TouchDown), for: .touchDown)
        restartButton.addTarget(self, action: #selector(button4TouchUp), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(button4TouchUp), for: .touchUpOutside)
        
        playButton.addTarget(self, action: #selector(button5TouchDown), for: .touchDown)
        playButton.addTarget(self, action: #selector(button5TouchUp), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(button5TouchUp), for: .touchUpOutside)
        
        leaderboardButton.setTitle("Leaderboard", for: .normal)
        leaderboardButton.titleLabel?.font = UIFont(name: "Supercell-Magic", size: 15.0)
        leaderboardButton.setTitleColor(UIColor(red: 254/255, green: 253/255, blue: 212/255, alpha: 1.0), for: .normal)
        leaderboardButton.setTitleShadowColor(UIColor(red: 127/255, green: 54/255, blue: 19/255, alpha: 1.0), for: .normal)
        leaderboardButton.titleLabel?.shadowOffset = CGSize(width: 0.0, height: 3.0)
        
    }
    
    
    func disableFlagButtons() {
        flagButton1.isEnabled = false
        flagButton2.isEnabled = false
        flagButton3.isEnabled = false
    }
    func enableFlagButtons() {
        flagButton1.isEnabled = true
        flagButton2.isEnabled = true
        flagButton3.isEnabled = true
    }
    
    
    
    @objc func button4TouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.restartButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @objc func button4TouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.restartButton.transform = CGAffineTransform.identity
        }
    }
    @objc func button5TouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.playButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @objc func button5TouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.playButton.transform = CGAffineTransform.identity
        }
    }
    
    func handleWrongAnswer(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(translationX: 30, y: 0)
        }) { finished in
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
    }
    
    func handleRightAnswer(button: UIButton) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, animations: {
            button.transform = CGAffineTransform(scaleX: 2.3, y: 2.3)
        })
        button.transform = .identity
    }
    
    
    
    //game logic
    func askQuestion(action: UIAlertAction! = nil) {
        scoreLabel.text = "Score: \(currentScore)"
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        //setting the name of the country to guess in a different color
        let countryName = countries[correctAnswer].uppercased()
        let labelText = "Guess the flag of \(countryName)"
        let attributedString = NSMutableAttributedString(string: labelText)
        let range = (labelText as NSString).range(of: countryName)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)], range: range)
        
        headerLabel.attributedText = attributedString
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.minimumScaleFactor = 0.5
        
        flagButton1.setImage(UIImage(named: countries[0]), for: .normal)
        flagButton2.setImage(UIImage(named: countries[1]), for: .normal)
        flagButton3.setImage(UIImage(named: countries[2]), for: .normal)
        
        enableFlagButtons()
    }
    
    
    func startGame() {
        enableFlagButtons()
        restartGame()
        updateTimerLabel()
        isGameActive = true
        isTimerActive = true
        playButton.isEnabled = false
        
        if isTimerActive {
            startTimer()
        }
    }
    func startGameButtonAlert() {
        let startAlert = UIAlertController(title: "Get ready! \n You have 45 seconds to answer each question.", message: "", preferredStyle: .alert)
        startAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.askQuestion()
            self.startGame()
            self.startTimer()
            self.playButton.isEnabled = false
        }))
        present(startAlert, animated: true, completion: nil)
    }
    
    func restartGame(action: UIAlertAction! = nil) {
        currentScore = 0
        askQuestion()
        secondsRemaining = 5
        updateTimerLabel()
        startTimer()
    }
    func restartGameButtonAlert() {
        let restartAlert = UIAlertController(title: "Want to start a new game ?", message: nil, preferredStyle: .alert)
        
        restartAlert.addAction(UIAlertAction(title: "NO", style: .default))
        restartAlert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (_) in
            self.restartGame(action: nil)
        }))
        
        present(restartAlert, animated: true)
    }
    
    
    
    @IBAction func flagButtonTapped(_ sender: UIButton) {

        if sender.tag == correctAnswer {
            currentScore += 1
            handleRightAnswer(button: sender)
            updateScoreLabel()
            askQuestion()
            saveScore()
            
            let path = Bundle.main.path(forResource: "correct.mp3", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            do {
                correctAnswerEffect = try AVAudioPlayer(contentsOf: url)
                correctAnswerEffect?.play()
            } catch {
                print("Couldn't load file.")
            }
            
            
        } else {
            currentScore -= 1
            handleWrongAnswer(button: sender)
            updateScoreLabel()
            timer?.invalidate()
            
            let path = Bundle.main.path(forResource: "wrong.mp3", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            do {
                correctAnswerEffect = try AVAudioPlayer(contentsOf: url)
                correctAnswerEffect?.play()
            } catch {
                print("Couldn't load file.")
            }
            
            let buttonAc = UIAlertController(title: "That was the flag of \(countries[sender.tag].uppercased())! \n - 1 point.", message: "", preferredStyle: .alert)
            buttonAc.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.startTimer() //timer restarts when the user closes the alert by pressing OK
                self.askQuestion()
            }))
            present(buttonAc, animated: true)
        }
    }
    
    
    @IBAction func leaderBoardButtonTapped(_ sender: UIButton) {
        let secondController = storyboard!.instantiateViewController(withIdentifier: "LeaderBoardViewController") as! SecondViewController
        secondController.currentScore = self.currentScore
        
        self.present(secondController, animated: true, completion: nil)
    }
    
    
    
    //timer management
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicking), userInfo: nil, repeats: true)
    }
    
    func updateTimerLabel() {
        timerLabel.text = "Time: \(max(0, secondsRemaining))s"
    }
    
    @objc func timerTicking() {
        if !isAlertPresented {
            secondsRemaining -= 1
        }
        
        if secondsRemaining == 0 {
            timer?.invalidate()
            timeUpAlert()
            updateTimerLabel()
            isGameActive = false
            playButton.isEnabled = true
        } else {
            updateTimerLabel()
        }
    }
    
    func timeUpAlert() {
        let alert = UIAlertController(title: "Time's Up! \n Your final score is \(currentScore). \n Can you do better next time ?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        timer?.invalidate()
        disableFlagButtons()
        headerLabel.text = "Guess the flag"
        
        saveScore()
    }
    
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        restartGameButtonAlert()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        enableFlagButtons()
        startGameButtonAlert()
    }
    
    
    
    func saveScore() {
        UserDefaults.standard.set(currentScore, forKey: "currentScore")
    }
    
    
    
    
}
    
    
    

