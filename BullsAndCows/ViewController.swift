//
//  ViewController.swift
//  BullsAndCows
//
//  Created by Brian Hu on 5/19/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, GenerateAns {
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var answearLabel: UILabel!
    var remainingTime: UInt8! {
        didSet {
            remainingTimeLabel.text = "remaining time: \(remainingTime)"
            if remainingTime == 0 {
                guessButton.enabled = false
            }else if remainingTime <= 3 {
                remainingTimeLabel.textColor = UIColor.redColor()
            }else if remainingTime <= 6 {
                remainingTimeLabel.textColor = UIColor.yellowColor()
            }else {
                guessButton.enabled = true
            }
        }
    }
    
    var hintArray = [(guess: String, hint: String)]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // TODO: 1. decide the data type you want to use to store the answear
    var answear: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGame()
    }
    
    func setGame() {
        generateAnswear()
        remainingTime = 9
        hintArray.removeAll()
        answearLabel.text = nil
        guessTextField.text = nil
    }
    
    func generateAnswear() {
        
        var numArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for _ in 0...3 {
            let n = Int(arc4random_uniform(UInt32(numArray.count)))
            answear = answear + (numArray.removeAtIndex(n))
        }
        
    }
    // TODO: 2. generate your answear here
    // You need to generate 4 random and non-repeating digits.
    // Some hints: http://stackoverflow.com/q/24007129/938380
    
    
    @IBAction func guess(sender: AnyObject) {
        
        let guessString = guessTextField.text
        
        guard guessString?.characters.count == 4 else {
            let alert = UIAlertController(title: "you should input 4 digits to guess!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if Set(guessString!.characters).count < 4 {
            let alert = UIAlertController(title: "you should not put duplicate numbers!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // TODO: 3. convert guessString to the data type you want to use and judge the guess
        
        var guessArr = Array(guessString!.characters)
        var ansArr = Array(answear.characters)
        
        var cows: Int = 0
        var bulls: Int = 0
        
        
        
        for r in 0...3{
            if guessArr[r] == ansArr[r]{
                cows += 1
            }else{
                for o in 0...3{
                    if guessArr[r] == ansArr[o]{
                        bulls += 1
                    }
                }
                
            }
        }
        
        // TODO: 4. update the hint
        
        let hint = "\(cows)A \(bulls)B"
        
        hintArray.append((guessString!, hint))
        
        // TODO: 5. update the constant "correct" if the guess is correct
        var correct = false
        if cows == 4 {
            correct = true
        }
        if correct {
            let alert = UIAlertController(title: "Wow! You are awesome!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            guessButton.enabled = false
        } else {
            remainingTime! -= 1
        }
        guessTextField.text = ""
    }
    @IBAction func showAnswear(sender: AnyObject) {
        // TODO: 6. convert your answear to string(if it's necessary) and display it
        answearLabel.text = "\(answear)"
    }
    
    @IBAction func playAgain(sender: AnyObject) {
        setGame()
        answear.removeRange(answear.startIndex..<answear.startIndex.advancedBy(4))
        remainingTimeLabel.textColor = UIColor.blackColor()
    }
    
    // MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hintArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Hint Cell", forIndexPath: indexPath)
        let (guess, hint) = hintArray[hintArray.count - 1 - indexPath.row]
        
        cell.textLabel?.text = "\(guess) => \(hint)"
        return cell
    }
}

/*
 
 var message = "asdf"
 
 String(message[message.startIndex.advancedBy(0)])  -> "a" :String
 message[message.startIndex.advancedBy(1)]  -> "s" :Character
 
 */
