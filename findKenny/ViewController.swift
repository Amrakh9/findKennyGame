//
//  ViewController.swift
//  findKenny
//
//  Created by Amrah on 30.05.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerCounter: UILabel!
    
    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var highestScore: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var timer = Timer()
    var counter = 10
    var currenttScore = 0
    var highestScoreCounter: [Int] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedScores = UserDefaults.standard.array(forKey: "highestScores") as? [Int] {
            highestScoreCounter = storedScores
        }
        // Update the highest score label
        highestScore.text = "Highest Score: \(highestScoreCounter.max() ?? 0)"
        
        findkenny()
        }
//
        func findkenny(){
            currenttScore = 0
            timerCounter.text = "Time: \(counter)"
            timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
            
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(updateScoreValue))
            imageView.addGestureRecognizer(gestureRecognizer)
            
            moveKenny()
        }
    
    func moveKenny(){
        let maxX = view.bounds.width - imageView.frame.width
        let maxY = view.bounds.height - imageView.frame.height
                
        let randomX = CGFloat.random(in: 0...maxX)
        let randomY = CGFloat.random(in: 0...maxY)
                
        imageView.frame.origin = CGPoint(x: randomX, y: randomY)
    }
    
    //Time Counter
    @objc func timeCounter(){
        counter -= 1
        moveKenny()
        timerCounter.text = "Time: \(counter)"
        if counter == 0 {
            timer.invalidate()
            
            highestScoreCounter.append(currenttScore)
            saveScores()
            highestScore.text = "Highest Score: \(highestScoreCounter.max() ?? 0)"
            
            alertPopUp()
            counter = 10
        }
    }
    
    
    //Score counter
    @objc func updateScoreValue(){
        currenttScore += 1
        currentScore.text = "Score: \(currenttScore)"
    }
    
    func saveScores() {
        UserDefaults.standard.set(highestScoreCounter, forKey: "highestScores")
    }
    //Alert
    @objc func alertPopUp(){
        let alert = UIAlertController(title: "Finished", message: "Your score is: \(currenttScore)", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        let retryButton = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) { [self] UIAlertAction in
            findkenny()
        }
        alert.addAction(okButton)
        alert.addAction(retryButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
    
    
