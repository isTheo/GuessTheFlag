//
//  ViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Matteo Orru on 31/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    // rimuovere le bandiere che hai indovinato
    // valutare vista iniziale
    // punizione per la perdita di punteggio/ vite
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    
    
    @IBOutlet var altTitle: UILabel!
    @IBOutlet var scoreTxt: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestion = 0
    var isGameActive = false
    var isTimerActive = false
    var timer: Timer?
    var secondsRemaining = 45
    var isAlertPresented = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupInitialUI()
    }
    
    
    
    
    
    func setupInitialUI() {
        altTitle.text = "Guess the flag"
        scoreTxt.text = "Score: \(score)"
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us", "argentina", "barbados", "brasil", "canada", "cuba", "cyprus", "hong kong", "kazakhstan", "norway", "south africa", "south korea", "swaziland", "tunisia", "zambia"]
        
        setupButtonsUI()
        disableFlagButtons()
    }
    
    func updateScoreLabel() {
        scoreTxt.text = "Score: \(score)"
    }
    
    
    
    
    //buttons management
    func setupButtonsUI() {
        button1.layer.borderWidth = 3.0
        button2.layer.borderWidth = 3.0
        button3.layer.borderWidth = 3.0
        
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor
        //shadow color 167, 175, 183
        button1.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        button1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        button1.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button1.layer.shadowOpacity = 10.0
        button1.layer.shadowRadius = 10.0
        button1.layer.masksToBounds = false
        
        button2.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        button2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        button2.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button2.layer.shadowOpacity = 10.0
        button2.layer.shadowRadius = 10.0
        button2.layer.masksToBounds = false
        
        button3.backgroundColor = UIColor(red: 167/255, green: 175/255, blue: 183/255, alpha: 1.0)
        button3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 7.25).cgColor
        button3.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button3.layer.shadowOpacity = 10.0
        button3.layer.shadowRadius = 10.0
        button3.layer.masksToBounds = false
        
        button4.addTarget(self, action: #selector(button4TouchDown), for: .touchDown)
        button4.addTarget(self, action: #selector(button4TouchUp), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4TouchUp), for: .touchUpOutside)
        
        button5.addTarget(self, action: #selector(button5TouchDown), for: .touchDown)
        button5.addTarget(self, action: #selector(button5TouchUp), for: .touchUpInside)
        button5.addTarget(self, action: #selector(button5TouchUp), for: .touchUpOutside)
    }
    
    func disableFlagButtons() {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
    }
    func enableFlagButtons() {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
    }
    
    
    
    
    //buttons animation
    @objc func button4TouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.button4.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @objc func button4TouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.button4.transform = CGAffineTransform.identity
        }
    }
    @objc func button5TouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.button5.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @objc func button5TouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.button5.transform = CGAffineTransform.identity
        }
    }
    
    func handleWrongAnswer(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(translationX: 10, y: 0)
        }) { (_) in
                UIView.animate(withDuration: 0.1) {
                    button.transform = .identity
                }
            }
        }
    
    
    
    
    //game logic
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        //setting the name of the country to guess in a different color
        let countryName = countries[correctAnswer].uppercased()
        let labelText = "Guess the flag of \(countryName)"
        let attributedString = NSMutableAttributedString(string: labelText)
        let range = (labelText as NSString).range(of: countryName)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 208/255, green: 72/255, blue: 72/255, alpha: 1.0)], range: range)
        altTitle.attributedText = attributedString
        
        //original code: altTitle.text = "Guess the flag of \(countries[correctAnswer].uppercased())"
        altTitle.numberOfLines = 0
        altTitle.lineBreakMode = .byWordWrapping

        altTitle.adjustsFontSizeToFitWidth = true
        altTitle.minimumScaleFactor = 0.5
        
        scoreTxt.text = "Score: \(score)"
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        enableFlagButtons()
    }
    
    func start() {
        enableFlagButtons()
        restart()
        updateTimerLabel()
        isGameActive = true
        isTimerActive = true
        button5.isEnabled = false
        
        if isTimerActive {
            startTimer()
        }
    }
    
    func startGameAlert() {
        let startAlert = UIAlertController(title: "Get ready! \n You have 45 seconds to answer each question.", message: "", preferredStyle: .alert)
        startAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.askQuestion()
            self.start()
            self.startTimer()
            self.button5.isEnabled = false
        }))
        present(startAlert, animated: true, completion: nil)
    }
    
    
    func restart(action: UIAlertAction! = nil) {
        askedQuestion = 0
        score = 0
        askQuestion()
        secondsRemaining = 45
        updateTimerLabel()
        startTimer()
    }
    
    func restartButtonAlert() {
        let restartAlert = UIAlertController(title: "Want to start a new game ? \n Your current score will be cleared.", message: nil, preferredStyle: .alert)
        
        restartAlert.addAction(UIAlertAction(title: "No, continue", style: .default))
        restartAlert.addAction(UIAlertAction(title: "Yes, restart", style: .destructive, handler: { (_) in
            self.restart(action: nil)
        }))
        
        present(restartAlert, animated: true)
    }
    
    
    
    
    //flag buttons
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer {
            score += 1
            updateScoreLabel()
            askQuestion()
            
        } else {
            score -= 1
            handleWrongAnswer(button: sender)
            updateScoreLabel()
            //the timer stops when an incorrect answer is given
            timer?.invalidate()
            
            let buttonAc = UIAlertController(title: "Too bad! \n That was the flag of \(countries[sender.tag].uppercased()). \n - 1 point.", message: "", preferredStyle: .alert)
            buttonAc.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.startTimer() //timer restarts when the user closes the alert by pressing OK
                self.askQuestion()
            }))
            present(buttonAc, animated: true)
        }
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
            button5.isEnabled = true
        } else {
            updateTimerLabel()
        }
    }
    
    func timeUpAlert() {
        let alert = UIAlertController(title: "Time's Up! \n Your final score is \(score). \n Can you do better next time ?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        timer?.invalidate()
        disableFlagButtons()
        altTitle.text = "Guess the flag"
        }
    
    
    
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartButtonAlert()
    }
    
    @IBAction func playGame(_ sender: UIButton) {
        enableFlagButtons()
        startGameAlert()
    }
    
    
    
    

    
    
    
    
}
    
    
    

