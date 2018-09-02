//
//  ChallengePlayViewController.swift
// Fd
//
//  Created by Eman I on 12/26/15.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 8.0, *)
class ChallengePlayViewController: UIViewController {

    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var multiplier: UILabel!
    @IBOutlet var harderLabel: UILabel!
    @IBOutlet var scoreCircle: UIButton!
    
    @IBOutlet var checkImage: UIImageView!
    @IBOutlet var rotateLogo: UIImageView!
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var imageView: UIImageView!
    var player:AVAudioPlayer = AVAudioPlayer()
    var postImage: UIImage!
    
    @IBAction func actionButtonHandler(sender: UIButton) {
        timer.invalidate()
        //cardButton.enabled = true
        let userSelection = sender.titleLabel!.text
        if (questionCount % 9 == 0) {
            
        }  else {
            userRatedString(userSelection!)
        }
        
        if correctAnswer == "Any" {
            sender.backgroundColor = UIColor.greenColor()
            correctInARow++
            print("These are correct in a row \(correctInARow)")
            let multiplierLabel = correctInARow * 2
            multiplier.text = "+\(multiplierLabel)"
            multiplier.hidden = false
            multiplier.alpha = 1
            
            UIView.animateWithDuration(3.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.multiplier.center = CGPoint(x:67.5, y:20)
                self.multiplier.alpha = 0
                
                }, completion: nil)
            
            currentScore = multiplierLabel + currentScore
            //imageView.image = UIImage(named:"rightpic\(typeOfGraphics).jpg")
            checkImage.image = UIImage (named:"check.png")
            checkImage.hidden = false
            imageView.alpha = 0.5
            
            if correctInARow == 5 {
                
                
                harderLabel.hidden = false
                harderLabel.text = "Whoa that's 5 in a row!"
                answerButtons.forEach({ (button) -> () in
                    button.hidden = true
                })
                //imageView.image = UIImage(named:"3rowpic\(typeOfGraphics).jpg")
                checkImage.image = UIImage (named:"check.png")
                checkImage.hidden = false
                imageView.alpha = 0.5
                playSound("3RowSound", fileType: ".mp3")
                scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                
                if questionCount < 9 {
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "hardNextQuestion" , userInfo: nil, repeats: false)
                } else {
                    showAlert(false)
                }
                
            } else if correctInARow == 3 {
                
                
                harderLabel.hidden = false
                harderLabel.text = "3 in a row!"
                answerButtons.forEach({ (button) -> () in
                    button.hidden = true
                })
                //imageView.image = UIImage(named:"3rowpic\(typeOfGraphics).jpg")
                checkImage.image = UIImage (named:"check.png")
                checkImage.hidden = false
                imageView.alpha = 0.5
                playSound("3RowSound", fileType: ".mp3")
                scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                
                if questionCount < 9 {
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "nextQuestion" , userInfo: nil, repeats: false)
                } else {
                    showAlert(false)
                }
                
            }
            else if correctInARow > 5 {
                playSound("powerup", fileType: ".wav")
                scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                
                if questionCount < 9 {
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "hardNextQuestion" , userInfo: nil, repeats: false)
                } else {
                    showAlert(false)
                }
                
            }
            else {
                playSound("powerup", fileType: ".wav")
                scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                
                if questionCount < 9 {
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "nextQuestion" , userInfo: nil, repeats: false)
                } else {
                    showAlert(false)
                }
                
            }
        } else if
            sender.titleLabel!.text == correctAnswer {
                //sender.backgroundColor = UIColor.greenColor()
                correctInARow++
                print("These are correct in a row \(correctInARow)")
                let multiplierLabel = correctInARow * 2
                multiplier.text = "+\(multiplierLabel)"
                multiplier.hidden = false
                multiplier.alpha = 1
                
                UIView.animateWithDuration(3.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    
                    self.multiplier.center = CGPoint(x:67.5, y:20)
                    self.multiplier.alpha = 0
                    
                    }, completion: nil)
                
                currentScore = multiplierLabel + currentScore
                //imageView.image = UIImage(named:"rightpic\(typeOfGraphics).jpg")
                checkImage.image = UIImage (named:"check.png")
                checkImage.hidden = false
                imageView.alpha = 0.5
                
                
                if correctInARow == 5 {
                    
                    
                    harderLabel.hidden = false
                    harderLabel.text = "Whoa that's 5 in a row!"
                    answerButtons.forEach({ (button) -> () in
                        button.hidden = true
                    })
                    //imageView.image = UIImage(named:"3rowpic\(typeOfGraphics).jpg")
                    checkImage.image = UIImage (named:"check.png")
                    checkImage.hidden = false
                    imageView.alpha = 0.5
                    playSound("3RowSound", fileType: ".mp3")
                    scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                    
                    if questionCount < 9 {
                    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "hardNextQuestion" , userInfo: nil, repeats: false)
                    } else {
                        showAlert(false)
                    }
                    
                } else if correctInARow == 3 {
                    
                    
                    harderLabel.hidden = false
                    harderLabel.text = "3 in a row!"
                    answerButtons.forEach({ (button) -> () in
                        button.hidden = true
                    })
                    //imageView.image = UIImage(named:"3rowpic\(typeOfGraphics).jpg")
                    checkImage.image = UIImage (named:"check.png")
                    checkImage.hidden = false
                    imageView.alpha = 0.5
                    playSound("3RowSound", fileType: ".mp3")
                    scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                    
                    if questionCount < 9 {
                    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "nextQuestion" , userInfo: nil, repeats: false)
                    } else {
                        showAlert(false)
                    }
                    
                }
                else if correctInARow > 5 {
                    playSound("powerup", fileType: ".wav")
                    scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                    
                    if questionCount < 9 {
                    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "hardNextQuestion" , userInfo: nil, repeats: false)
                    } else {
                        showAlert(false)
                    }
                    
                }
                    
                else {
                    playSound("powerup", fileType: ".wav")
                    scoreCircle.setTitle("Score:\(currentScore)", forState: .Normal)
                    
                    if questionCount < 9 {
                    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "nextQuestion" , userInfo: nil, repeats: false)
                    } else {
                        showAlert(false)
                    }
                    
                }
        } else {
            sender.backgroundColor = UIColor.redColor()
            correctInARow = 0
            print("These are correct in a row \(correctInARow)")
            //imageView.image = UIImage(named:"wrongpic\(typeOfGraphics).jpg")
            checkImage.image = UIImage(named:"x.png")
            checkImage.hidden = false
            imageView.alpha = 0.5
            playSound("guitar", fileType: ".wav")
            
            if questionCount < 9 {
                
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: "nextQuestion" , userInfo: nil, repeats: false)
                
            } else {
                showAlert(false)
            }
        }
        for button in answerButtons {
            button.enabled = false
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
        

        if questionIdx < 9 {
            questionIdx++
            questionCount++
        } else {
            gameReview()
            showAlert(false)
        }
        
    }
    
    var correctAnswer: String?
    
    var image: String?
    
    var answers = [String]()
    
    var questionIdx = 0
    
    var timer = NSTimer()
    
    var currentScore = 0
    
    var chances = 0
    
    var correctInARow = 0
    
    var userQuery = PFQuery(className: "User")//PFUser(className: "Users")
    
    var outfitQuery = PFQuery(className: "Outfit")
    
    var highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
    
    var easyAnswerChoices:[String] = ["Below 70", "Somewhere In The Middle", "Above 90"]
    
    var medAnswerChoices:[String] = ["60s", "70s", "80s", "90s"]
    
    var wrongSounds = ["guitar", "jazzy0", "novoice"]
    
    var typeOfGraphics = 0
    
    var questionCount = 0
    
    var obID = String()
    
    var gameViews = NSNumber()
    
    var gameAverage = NSNumber()
    
    
    //  var allAnswerChoices:[Int] = [1,2,3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(red: 232/255.0, green: 240/255.0, blue: 243/255.0, alpha: 1.0)
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.hidden
        // Do any additional setup after loading the view.
        multiplier.hidden = true
        harderLabel.hidden = true
        progressView.transform = CGAffineTransformScale(progressView.transform, 1, 6)
        
        PFCloud.callFunctionInBackground("incrementGamesPlayed", withParameters: ["userId": currentId]) {
            (ratings, error) in
            if (error == nil) {
                print("error with incrementing GamesPlayed \(ratings)")
                // ratings is 4.5
            }
        }
        
        let graphicsNumber: UInt32 = 2
        typeOfGraphics = Int(arc4random_uniform(graphicsNumber))
        
        let gameCount = PFQuery(className:"GameVS")
        gameCount.getObjectInBackgroundWithId(gamesPlayedId) {
            (games: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let games = games {
    
                var count = 0
                if games["gamesPlayed"] == nil {
                    count = 0
                    count++
                    games["gamesPlayed"] = count as NSNumber
                    games.saveInBackground()
                } else {
                 count = Int(games["gamesPlayed"] as! NSNumber)
                 count++
                 games["gamesPlayed"] = count as NSNumber
                 games.saveInBackground()
                }
            }
        }
        
                
        nextQuestion()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.hidden
        
        //navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound(fileName:String, fileType:String){
        let correctSound = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: correctSound!))
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }
        
        player.play()
    }
    
    func userRatedString(choice: String){
        var starRating = 5.0
        if choice == "Below 70" { starRating = 1.5}
        else if choice == "Somewhere In The Middle" { starRating = 3.5}
        else if choice == "Above 90" { starRating = 5.0}
        else {
            if Int(choice) > 85 {starRating = 5.0}
            else if Int(choice) > 60 {starRating = 3.5}
            else if Int(choice) > 0 {starRating = 1.5}
        }
        
        let score = Double(((gameAverage as Double  * (gameViews as Double)) + starRating)/(gameViews as Double + 1.0))
        print("this is game Average \(gameAverage) this is  views \(gameViews) this is the score \(score)")
        
        
        PFCloud.callFunctionInBackground("updateFadstirGameAverage", withParameters: ["outfitId": obID, "gameAverage": score]) {
            (ratings, error) in
            if (error == nil) {
                print(ratings)
                // ratings is 4.5
            }
        }
        
        
       
        
    }
    
    func nextQuestion() {
        
        answerButtons.forEach({ (button) -> () in
            button.hidden = false
        })
        easyAnswerChoices = ["Below 70", "Somewhere In The Middle", "Above 90"]
        if questionCount > 9 {
            showAlert(false)
        }
        
        
        self.imageView.alpha = 1.0
        multiplier.hidden = true
        harderLabel.hidden = true
        checkImage.hidden = true
        
        //Figure out the fadstirScore
        print("this is where we are with question index \(questionIdx)")
        let fadS = outfitFadScores[questionIndex[questionIdx]]
        obID = challengeObjectIds[questionIndex[questionIdx]]
        gameViews = outfitGameViews[questionIndex[questionIdx]]
        gameAverage = outfitGameAverage[questionIndex[questionIdx]]
        print("-----------Entering User Question Section For this outfit \(obID) -----------")
        
        //increment Game Views
        PFCloud.callFunctionInBackground("incrementFadstirGameViews", withParameters: ["outfitId": obID]) {
            (ratings, error) in
            if (error == nil) {
                print("no problem with adding to views in outfit class \(ratings)")
                
            }
        }
        //increase Outfit Views
        PFCloud.callFunctionInBackground("increaseOutfitViews", withParameters: ["outfitId": obID]) {
            (ratings, error) in
            if (error == nil) {
                print(ratings)
            }
        }
        var finalScore = 0
        
        if String(fadS) == "0" {// see if its 0
            correctAnswer = "Any"
        } else {
            let fadScoreDouble = (fadS as Double)
            finalScore = Int(fadScoreDouble / 5 * 100)
            print("this is the outfit score \(finalScore)")
            
            if finalScore >= 90 {
                correctAnswer = "Above 90"
            } else if finalScore > 69 {
                correctAnswer = "Somewhere In The Middle"
            } else {
                correctAnswer = "Below 70"
            }
            
        }
        print("this is the correct answer\(correctAnswer)")
        
        //Get the right Image
        
        
            let questionImage = outfitImages[questionIndex[questionIdx]]
            questionImage.getDataInBackgroundWithBlock { (data, error) -> Void in
                print("we're using this image \(self.obID)")
                if error == nil {
                    if let downloadedImage = UIImage(data: data!) {
                        if downloadedImage == UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!) {
                                    self.correctAnswer = "Any"
                        } else {
                            self.imageView.image = downloadedImage
                        }
                    }
                }
            }

        
        //send 4 strings
        titlesForButtons(easyAnswerChoices)
        
        //initialize AVFoundation
        if questionIdx != 0 {
            
            let correctSound = NSBundle.mainBundle().pathForResource("powerup", ofType: ".mp3")
            
            do {
                player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: correctSound!))
                
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
            }
            catch {
                print("Something bad happened. Try catching specific errors to narrow things down")
            }
            player.pause()
            
        }
    }
    
    func hardNextQuestion() {
        
        player.pause()
        answerButtons.forEach({ (button) -> () in
            button.hidden = false
        })
        if questionCount > 9 {
            showAlert(false)
        }
        
        self.imageView.alpha = 1.0
        multiplier.hidden = true
        checkImage.hidden = true
        harderLabel.hidden = true
        //var medAnswerChoices:[String] = ["0", "1", "2", "3"]
        var top: UInt32 = 100
        var bottom: UInt32 = 0
        
        //Figure out the fadstirScore
        let fadS = outfitFadScores[questionIndex[questionIdx]]
        obID = challengeObjectIds[questionIndex[questionIdx]]
        gameViews = outfitGameViews[questionIndex[questionIdx]]
        gameAverage = outfitGameAverage[questionIndex[questionIdx]]
        var finalScore = 0
        
        //increment Game Views
        PFCloud.callFunctionInBackground("incrementFadstirGameViews", withParameters: ["outfitId": obID]) {
            (ratings, error) in
            if (error == nil) {
                print("no problem with adding to views in outfit class \(ratings)")
                
            }
        }
        //increase Outfit Views
        PFCloud.callFunctionInBackground("increaseOutfitViews", withParameters: ["outfitId": obID]) {
            (ratings, error) in
            if (error == nil) {
                print(ratings)
            }
        }
        if String(fadS) == "0" {
            correctAnswer = "Any"
            top = 100
            bottom = 60
            finalScore = Int(arc4random_uniform(UInt32(35))) + 30
            randomAnswerChoices(top, bottom: bottom, fadstirScore: finalScore)
        } else {
            let fadScoreDouble = (fadS as Double)
            finalScore = Int(fadScoreDouble / 5 * 100)
            correctAnswer = "\(finalScore)"
            
            
            //If score is 90+ then random # high as 100 low as 50
            if finalScore > 89 {
                top = 100
                bottom = 80
            }
                //if score is 80-89 then high as 100 low as 50
            else if finalScore > 79 && finalScore < 90 {
                top = 100
                bottom = 70
            }
                //if score is 70-79 then high as 100 low as 50
            else if finalScore > 69 && finalScore < 80 {
                top = 100
                bottom = 60
            }
                //if score is 60-69 then high as 90 low as 40
            else if finalScore > 59 && finalScore < 70 {
                top = 90
                bottom = 55
            }
                //if score is 1-59 then high as 80 low as 20
            else if finalScore > 0 && finalScore < 60 {
                top = 80
                bottom = 30
            }
                // if score is 0 then random score from 85-95|75-84|65-74|55-64
            else {
                top = 100
                bottom = 30
            }
            randomAnswerChoices(top, bottom: bottom, fadstirScore: finalScore)
            
            
        }
        
        easyAnswerChoices.shuffle()
        easyAnswerChoices.shuffle()
        
        print("this is the correct answer\(correctAnswer!)")
        
        
        
        //Get the right Image
        let questionImage = outfitImages[questionIndex[questionIdx]]
        questionImage.getDataInBackgroundWithBlock { (data, error) -> Void in
            print("we're using this image \(self.obID)")
            if error == nil {
                if let downloadedImage = UIImage(data: data!) {
                    if downloadedImage == UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!) {
                        self.correctAnswer = "Any"
                    } else {
                        self.imageView.image = downloadedImage
                    }
                }
            }
        }
        //send 4 strings
        print("answers before make buttons")
        print(easyAnswerChoices)
        titlesForButtons(easyAnswerChoices)
    }
    
  
    
    //Random answers generator
    func randomAnswerChoices(top: UInt32, bottom: UInt32, fadstirScore: Int) {
        var randomNumber = 0
        easyAnswerChoices = ["0", "0", "0"]
        easyAnswerChoices[2] = ("\(fadstirScore)")
        
        for var i = 0; i < 2; i++ {
            randomNumber = Int(arc4random_uniform(top - bottom) + bottom)
            if randomNumber == fadstirScore || easyAnswerChoices.contains("\(randomNumber)") {
                print("we got here, but didn't fix it")
                print(easyAnswerChoices)
                print("this is the fadstir Score \(fadstirScore) and this is the random number \(randomNumber)")
                
                randomAnswerChoices(top, bottom: bottom, fadstirScore: fadstirScore)
                print("we shoud not reach here")
                //so answers are not repeated
            } else{
                easyAnswerChoices[i] = "\(randomNumber)"
            }
        }
        
        
    }
    
    
    
    
    
    
    func startTimer() {
        progressView.progress = 1.0
        progressView.progressTintColor = UIColor(red: 1/255.0, green: 112/255.0, blue: 123/255.0, alpha: 1.0)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        UIView.animateWithDuration(15.0, animations: {
            self.rotateLogo.transform = CGAffineTransformMakeRotation((CGFloat(M_PI)))
        })
        UIView.animateWithDuration(15.0, animations: {
            self.rotateLogo.transform = CGAffineTransformMakeRotation( 0.0 * (CGFloat(M_PI)) / 180.0)
        })
        UIView.animateWithDuration(15.0, animations: {
            self.rotateLogo.transform = CGAffineTransformMakeRotation((CGFloat(M_PI)))
        })
        UIView.animateWithDuration(15.0, animations: {
            self.rotateLogo.transform = CGAffineTransformMakeRotation( 0.0 * (CGFloat(M_PI)) / 180.0)
        })
        
    }
    
    @available(iOS 8.0, *)
    func updateProgressView() {
        progressView.progress -= 0.01/15
        if progressView.progress <= 0 {
            outOfTime()
        }
        if progressView.progress <= 0.5 {
            progressView.progressTintColor = UIColor.redColor()
        }
    }
    
    @available(iOS 8.0, *)
    func outOfTime() {
        
        timer.invalidate()
        if questionCount > 9 {
            showAlert(false)
        }
        //disableButtons()
        
        if questionIdx < 9 {
            questionIdx++
            questionCount++
            nextQuestion()
        } else {
            showAlert(false)
            gameReview()
        }
    }
    
    func disableButtons() {
        for button in answerButtons {
            button.enabled = false
        }
        UIView.animateWithDuration(15.0, animations: {
            self.rotateLogo.transform = CGAffineTransformMakeRotation( 360.0 * (CGFloat(M_PI)) / 360.0)
        })
    }
    
    @available(iOS 8.0, *)
    func showAlert(slow: Bool){
        
        var title: String?
        
        if slow {
            title = "Out of time yo!"
        } else {
            title = "That's the end"
        }
        
        var alertController = UIAlertController(title: title, message: "You got a score of \(currentScore).  Let's check out the others in the standings", preferredStyle: UIAlertControllerStyle.Alert)
        var ok = UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in
            self.gameReview()
            
        })
        
        if currentScore > highscore {
            highscore = currentScore
            playSound("highscorecheer", fileType: ".mp3")
            //code to save highscore in Parse in fadstirGameHighScore column
            PFCloud.callFunctionInBackground("updateUserHighScore", withParameters: ["userId": currentId, "highScore" : highscore]) {
                (ratings, error) in
                if (error == nil) {
                    print("problem with updating highscore \(ratings)")
                    
                }
            }
            title = "Way to Go!"
            NSUserDefaults.standardUserDefaults().setInteger(highscore, forKey: "highscore")
            alertController = UIAlertController(title: title, message: "You got a HIGH SCORE of \(currentScore)!!!  Let's check out the others in the standings", preferredStyle: UIAlertControllerStyle.Alert)
            ok = UIAlertAction(title: "Awesome!", style: .Default, handler: { (alert: UIAlertAction!) in
                self.gameReview()
                
            })
            
        }
        NSUserDefaults.standardUserDefaults().setInteger(currentScore, forKey: "score")
        // save score to parse
        let aclReadWrite = PFACL()
        aclReadWrite.setPublicReadAccess(true)
        aclReadWrite.setPublicWriteAccess(true)
        
        let aclRead = PFACL()
        aclRead.setPublicReadAccess(true)
        aclRead.setPublicWriteAccess(false)
        
        let scoreQuery = PFQuery(className:"GameVS")
        scoreQuery.getObjectInBackgroundWithId(gameVSId) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = gameScore {
                gameScore.ACL.setPublicWriteAccess(true)
                //gameScore.ACL = aclReadWrite
                    //gameScore.setAcl(aclReadWrite)
                
                //test this
                var didWorkCount = 0
                if gameScore["startPlayer"] != nil && !(gameScore["startPlayer"]!.isEqual(NSNull())) {
                    if currentId == gameScore["startPlayer"].objectId as String{
                        gameScore["startPlayerScore"] = self.currentScore as NSNumber
                        print("saved to startplayer")
                        didWorkCount++
                    }}
                if gameScore["firstOpponent"] != nil && !(gameScore["firstOpponent"]!.isEqual(NSNull())) {
                    if currentId == gameScore["firstOpponent"].objectId as String{
                        gameScore["firstOpponentScore"] = self.currentScore as NSNumber
                        print("saved to first player")
                        didWorkCount++
                    }}
                if gameScore["secondOpponent"] != nil && !(gameScore["secondOpponent"]!.isEqual(NSNull())) {
                    if currentId == gameScore["secondOpponent"].objectId as String{
                        gameScore["secondOpponentScore"] = self.currentScore as NSNumber
                        print("saved to second player")
                        didWorkCount++
                    }}
                if gameScore["thirdOpponent"] != nil && !(gameScore["thirdOpponent"]!.isEqual(NSNull())) {
                    if currentId == gameScore["thirdOpponent"].objectId as String{
                        gameScore["thirdOpponentScore"] = self.currentScore as NSNumber
                        print("saved to third player")
                        didWorkCount++
                    }}
                if gameScore["fourthOpponent"] != nil && !(gameScore["fourthOpponent"]!.isEqual(NSNull())) {
                    if currentId == gameScore["fourthOpponent"].objectId as String{
                        gameScore["fourthOpponentScore"] = self.currentScore as NSNumber
                        print("saved to fourth player")
                        didWorkCount++
                    }}
                if didWorkCount == 0 {print ("didn't work for anyone")}
                
                gameScore.saveInBackground()
            }
        }
        
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func gameReview() {
        comingFromGame = true
        let secondViewController = ChallengeStatusViewController(nibName:"ChallengeStatusViewController", bundle: nil)
        self.navigationController?.pushViewController(secondViewController, animated: true)
        //self.presentViewController(secondViewController, animated: false, completion: nil)
        
    }
    func titlesForButtons(choicesArray: [String]) {
        //button titles array
        
        for (idx,button) in answerButtons.enumerate(){
            button.titleLabel!.lineBreakMode = .ByWordWrapping
            button.setTitle(choicesArray[idx], forState: .Normal)
            button.enabled = true
            button.backgroundColor = UIColor.whiteColor()
        }
        //imageView.image = UIImage(named:image!)
        startTimer()
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
