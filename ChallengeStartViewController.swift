//
//  ChallengeStartViewController.swift
// Fd
//
//  Created by Eman I on 12/18/15.
//  Copyright © 2016 Eman. All rights reserved.
//
// slim down by creating separate arrays for images, fadscore, numof views

import UIKit
import MessageUI

@available(iOS 8.0, *)
class ChallengeStartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMessageComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate {

    
    
    //you can only challenge folks who follow you
    var numOpponents = 0
    var opponentsList = [String]()
    var opponentsObjects = [PFObject]()
    var pickerSelection = "user"
        @IBAction func addOpponent(sender: AnyObject) {
        instructionText.hidden = true
        userImage.hidden = false
        userImage2.hidden = false
        userImage3.hidden = false
        userImage4.hidden = false
        userName.hidden = false
        userName2.hidden = false
        userName3.hidden = false
        userName4.hidden = false
        
        print("these are the number of opponenets wright now \(numOpponents)")
        
        
        if !opponentsList.contains(pickerSelection) {
            opponentsList.append(pickerSelection)
            numOpponents++
        if numOpponents == 4 {
            userName4.text = pickerSelection
            userName4.alpha = 1.0
            addOpponentLabel.hidden = true
            userImage4.alpha = 1.0
            xbutton4Label.hidden = false
            
            let friendIndex = friends.indexOf(pickerSelection)
            print ("this is the index \(friendIndex)")
            if friendIndex != nil {
            friendImages[friendIndex!].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.userImage4.image = downloadedImage
                    }
                }
            }
            
            
        } else if numOpponents == 3 {
            userName3.text = pickerSelection
            userName3.alpha = 1.0
            userImage3.alpha = 1.0
            xbutton3Label.hidden = false
            
            let friendIndex = friends.indexOf(pickerSelection)
            print ("this is the index \(friendIndex)")
            if friendIndex != nil {
                friendImages[friendIndex!].getDataInBackgroundWithBlock { (data, error) -> Void in
                    if let downloadedImage = UIImage(data: data!) {
                        self.userImage3.image = downloadedImage
                    }
                }
            }
        } else if numOpponents == 2 {
            userName2.text = pickerSelection
            userName2.alpha = 1.0
            userImage2.alpha = 1.0
            xbutton2Label.hidden = false
            
            let friendIndex = friends.indexOf(pickerSelection)
            print ("this is the index \(friendIndex)")
            if friendIndex != nil {
                friendImages[friendIndex!].getDataInBackgroundWithBlock { (data, error) -> Void in
                    if let downloadedImage = UIImage(data: data!) {
                        self.userImage2.image = downloadedImage
                    }
                }
            }
        }
        else {
            userName.text = pickerSelection
            userName.alpha = 1.0
            userImage.alpha = 1.0
            xbutton1Label.hidden = false
            
            let friendIndex = friends.indexOf(pickerSelection)
            print ("this is the index \(friendIndex)")
            if friendIndex != nil {
                friendImages[friendIndex!].getDataInBackgroundWithBlock { (data, error) -> Void in
                    if let downloadedImage = UIImage(data: data!) {
                        self.userImage.image = downloadedImage
                    }
                }
            } else {
                self.userImage.image = UIImage(named: "statusIcon.png")
                }
            }
        }
        
    }
    
    var type = 0
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var columnToFilter:[String] = ["numberOfViews", "fadstirScore", "createdAt"]
    var column = "numberOfViews"

    var playerOrder = ["first", "second", "third", "fourth"]
    var challengeObjectIdsMen = [String]()
    var outfitImagesMen = [PFFile]()
    var outfitFadScoresMen = [NSNumber]()
    var challengeObjectIdsWomen = [String]()
    var outfitImagesWomen = [PFFile]()
    var outfitFadScoresWomen = [NSNumber]()
    var challengeObjectIdsBoth = [String]()
    var outfitImagesBoth = [PFFile]()
    var outfitFadScoresBoth = [NSNumber]()
    var outfitGameViewsMen = [NSNumber]()
    var outfitGameViewsWomen = [NSNumber]()
    var outfitGameViewsBoth = [NSNumber]()
    var outfitGameAverageMen = [NSNumber]()
    var outfitGameAverageWomen = [NSNumber]()
    var outfitGameAverageBoth = [NSNumber]()
    
    let emptyStringArray = [String]()
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var addOpponentLabel: UIButton!
    @IBOutlet var instructionText: UILabel!
    @IBOutlet var textMessageLabel: UIButton!
    @IBOutlet var openGamesLabel: UILabel!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var history: UIButton!
    @IBOutlet var userImage2: UIImageView!
    @IBOutlet var userName2: UILabel!
    @IBOutlet var userImage3: UIImageView!
    @IBOutlet var userName3: UILabel!
    @IBOutlet var userImage4: UIImageView!
    @IBOutlet var userName4: UILabel!
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet var xbutton1Label: UIButton!
    @IBAction func xbutton1Tap(sender: AnyObject) {
        let userToRemove = opponentsList.indexOf(userName.text!)
        opponentsList.removeAtIndex(userToRemove!)
        
        userImage.image = userImage2.image
        userName.text = userName2.text
       
        if userName2.text == "Add Challenger" {
            xbutton1Label.hidden = true
            
        }
        numOpponents--
        addOpponentLabel.hidden = false
        print(opponentsList)
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.1), target: self, selector: "moveUp3rdRow", userInfo: nil, repeats: false)
    }
    @IBOutlet var xbutton2Label: UIButton!
    @IBAction func xbutton2Tap(sender: AnyObject) {
        
        let userToRemove = opponentsList.indexOf(userName2.text!)
        opponentsList.removeAtIndex(userToRemove!)
        
        numOpponents--
        addOpponentLabel.hidden = false
        moveUp3rdRow()
        print(opponentsList)
    }
    @IBOutlet var xbutton3Label: UIButton!
    @IBAction func xbutton3Tap(sender: AnyObject) {
        
        let userToRemove = opponentsList.indexOf(userName3.text!)
        opponentsList.removeAtIndex(userToRemove!)
        
        numOpponents--
        addOpponentLabel.hidden = false
        moveUpLastRow()
        print(opponentsList)
    }
    @IBOutlet var xbutton4Label: UIButton!
    @IBAction func xbutton4Tap(sender: AnyObject) {
        
        let userToRemove = opponentsList.indexOf(userName4.text!)
        opponentsList.removeAtIndex(userToRemove!)
        
        resetLastRow()
        addOpponentLabel.hidden = false
        numOpponents--
        print(opponentsList)
    }
    
    
    @available(iOS 8.0, *)
    @IBAction func historyButton(sender: UIButton) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = instructionText.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5)
        //activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.
        activityIndicator.color = UIColor.blackColor()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
        let allHistoryQuery = PFQuery(className: "GameVS")
        var historyPlaceHolder = [String]()
        var historicGamesPlaceHolder = [PFObject]()
        var historyCountPlace = [Int]()
        allHistoryQuery.orderByDescending("createdAt")
        allHistoryQuery.whereKey("allPlayers", equalTo: currentId as String)
        allHistoryQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                var objCount = objects.count
                if objCount == 0 { self.goToHistory() }
                for object in objects {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
                    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                    let date = dateFormatter.stringFromDate(object.createdAt as NSDate)
                    historyPlaceHolder.append(date as String)
                    historicGamesPlaceHolder.append(object as! PFObject)
                    var opponents = [String]()
                    opponents = object["allPlayers"] as! [String]
                    historyCountPlace.append(opponents.count)
                    objCount--
                    if objCount == 0 { self.goToHistory() }
                    
 
            }
            if historyPlaceHolder.count > historyTableText.count {
                historyTableText = historyPlaceHolder
                allHistoricGames = historicGamesPlaceHolder
                historyOpponentCount = historyCountPlace
                
            }
            } else {
                self.goToHistory()
            }
        
       // NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "goToHistory", userInfo: nil, repeats: false)
     }
    }
    
    @available(iOS 8.0, *)
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    @available(iOS 8.0, *)
    @IBAction func textMessage(sender: AnyObject) {
                
        
        let secondViewController = PopUpViewController(nibName:"PopUpViewController", bundle: nil)
        secondViewController.modalPresentationStyle = .Popover
        secondViewController.preferredContentSize = CGSizeMake(300, 70)
        
        
        let popoverMenuViewController = secondViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Up
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender as? UIView
        let viewForSource = sender as? UIView
        popoverMenuViewController?.sourceRect = viewForSource!.bounds
        presentViewController(
            secondViewController,
            animated: true,
            completion: nil)
      

    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            
            print("the message was canceled")
            self.dismissViewControllerAnimated(true, completion: nil)
        
        case MessageComposeResultFailed.rawValue:
            
            print("the message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        
        case MessageComposeResultSent.rawValue:
            
            print("the message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        default:
            break
        }
        
    }
    @IBAction func playMen(sender: AnyObject) {
        if opponentsList.count > 0 {
            
            players = emptyStringArray
            playersUsernames = emptyStringArray
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.instructionText.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        challengeObjectIds = challengeObjectIdsMen
        outfitImages = outfitImagesMen
        outfitFadScores = outfitFadScoresMen
        outfitGameViews = outfitGameViewsMen
        outfitGameAverage = outfitGameAverageMen
        // get 10 random #s to use for array index for game
        var randQuestions = [Int]()
        for var i = 0; randQuestions.count < 10; i++ {
            let count = Int(arc4random_uniform(UInt32(challengeObjectIds.count)))
            if !randQuestions.contains(count) {
                randQuestions.append(count)
            }
        }
        questionIndex = randQuestions
        print(randQuestions)
        for var j = 0; j < questionIndex.count; j++ {
            tenChallengeIds.append(challengeObjectIds[questionIndex[j]])
        }
        print(tenChallengeIds)
        
            
            for var i = 0; i<opponentsList.count; i++ {
                let friendIndex = friends.indexOf(opponentsList[i])!
                players.append(friendIds[friendIndex])
                opponentsObjects.append(friendObjects[friendIndex])
            }
            let oppArray = players
            print("these are opponent names \(opponentsList) these are opponent IDs \(players)")
        
        //save stuff to parse
        players.append(currentId)
        let gameVS = PFObject(className:"GameVS")
        gameVS["startPlayer"] = PFUser.currentUser()
        gameVS["allPlayers"] = players
        gameVS["challengeIds"] = tenChallengeIds
            for var e = 0; e<opponentsObjects.count; e++ {
                gameVS["\(playerOrder[e])Opponent"] = opponentsObjects[e]
            }
            
       
        gameVS.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved this time around")
                gameVSId = gameVS.objectId
                gameVS.ACL.setPublicWriteAccess(true)
                PFCloud.callFunctionInBackground("createChallengeActivities", withParameters: ["userId": currentId, "gameId": gameVSId, "toUserIdArray": oppArray]) {
                    (ratings, error) in
                    if (error == nil) {
                        print(ratings)
                        // ratings is 4.5
                    }
                }

                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "startGame", userInfo: nil, repeats: false)
                                
            } else {
                // There was a problem, check error.description
                 print("failed this time")
            }
         }
        } else {
            showAlert2()
            print ("need an opponent")
        }
    }
    @IBAction func playWomen(sender: AnyObject) {
        if opponentsList.count > 0 {
        
            players = emptyStringArray
            playersUsernames = emptyStringArray
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.instructionText.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        challengeObjectIds = challengeObjectIdsWomen
        outfitImages = outfitImagesWomen
        outfitFadScores = outfitFadScoresWomen
        outfitGameAverage = outfitGameAverageWomen
        outfitGameViews = outfitGameViewsWomen
        // get 10 random #s to use for array index for game
        var randQuestions = [Int]()
        for var i = 0; randQuestions.count < 10; i++ {
            let count = Int(arc4random_uniform(UInt32(challengeObjectIds.count)))
            if !randQuestions.contains(count) {
                randQuestions.append(count)
            }
        }
        questionIndex = randQuestions
        print(randQuestions)
        for var j = 0; j < questionIndex.count; j++ {
            tenChallengeIds.append(challengeObjectIds[questionIndex[j]])
        }
        print(tenChallengeIds)
        
            
            for var i = 0; i<opponentsList.count; i++ {
                let friendIndex = friends.indexOf(opponentsList[i])!
                players.append(friendIds[friendIndex])
                opponentsObjects.append(friendObjects[friendIndex])
            }
            let oppArray = players
            print("these are opponent names \(opponentsList) these are opponent IDs \(players)")
        
        //save stuff to parse
        players.append(currentId)
        let gameVS = PFObject(className:"GameVS")
        gameVS["startPlayer"] = PFUser.currentUser()
        gameVS["allPlayers"] = players
        gameVS["challengeIds"] = tenChallengeIds
            for var e = 0; e<opponentsObjects.count; e++ {
                gameVS["\(playerOrder[e])Opponent"] = opponentsObjects[e]
            }
        gameVS.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved this time around")
                gameVSId = gameVS.objectId
                gameVS.ACL.setPublicWriteAccess(true)
                PFCloud.callFunctionInBackground("createChallengeActivities", withParameters: ["userId": currentId, "gameId": gameVSId, "toUserIdArray": oppArray]) {
                    (ratings, error) in
                    if (error == nil) {
                        print(ratings)
                        // ratings is 4.5
                    }
                }

                self.startGame()
            } else {
                // There was a problem, check error.description
                print("failed this time")
            }
        }
        
        } else {
            showAlert2()
            print ("need at least one opponent")
        }
    }
    @IBAction func playBoth(sender: AnyObject) {
        if opponentsList.count > 0 {
            players = emptyStringArray
            playersUsernames = emptyStringArray
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.instructionText.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //set arrays equal to proper ones
        challengeObjectIds = challengeObjectIdsBoth
        outfitImages = outfitImagesBoth
        outfitFadScores = outfitFadScoresBoth
        outfitGameViews = outfitGameViewsBoth
        outfitGameAverage = outfitGameAverageBoth
        // get 10 random #s to use for array index for game
        var randQuestions = [Int]()
        for var i = 0; randQuestions.count < 10; i++ {
        let count = Int(arc4random_uniform(UInt32(challengeObjectIds.count)))
            if !randQuestions.contains(count) {
                randQuestions.append(count)
            }
        }
        questionIndex = randQuestions
        print(randQuestions)
        print("this is question index couunt \(questionIndex.count)")
        for var j = 0; j < questionIndex.count; j++ {
            tenChallengeIds.append(challengeObjectIds[questionIndex[j]])
        }
        print(tenChallengeIds)
        
            for var i = 0; i<opponentsList.count; i++ {
                let friendIndex = friends.indexOf(opponentsList[i])!
                players.append(friendIds[friendIndex])
                opponentsObjects.append(friendObjects[friendIndex])
            }
            let oppArray = players
            print("these are opponent names \(opponentsList) these are opponent IDs \(players)")
        
        //save stuff to parse
        players.append(currentId)
        let gameVS = PFObject(className:"GameVS")
        gameVS["startPlayer"] = PFUser.currentUser()
        gameVS["allPlayers"] = players
        gameVS["challengeIds"] = tenChallengeIds
            for var e = 0; e<opponentsObjects.count; e++ {
                gameVS["\(playerOrder[e])Opponent"] = opponentsObjects[e]
            }
        gameVS.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved this time around")
                gameVSId = gameVS.objectId
                gameVS.ACL.setPublicWriteAccess(true)
                PFCloud.callFunctionInBackground("createChallengeActivities", withParameters: ["userId": currentId, "gameId": gameVSId, "toUserIdArray": oppArray]) {
                    (ratings, error) in
                    if (error == nil) {
                        print(ratings)
                        // ratings is 4.5
                    }
                }

                self.startGame()
            } else {
                // There was a problem, check error.description
                print("failed this time")
            }
        }
        } else {
            showAlert2()
            print ("need 1 opponent")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        xbutton1Label.hidden = true
        xbutton2Label.hidden = true
        xbutton3Label.hidden = true
        xbutton4Label.hidden = true
        userImage.hidden = true
        userImage2.hidden = true
        userImage3.hidden = true
        userImage4.hidden = true
        userName.hidden = true
        userName2.hidden = true
        userName3.hidden = true
        userName4.hidden = true
        openGamesLabel.hidden = true
        
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.blackColor().CGColor
        userImage.layer.borderWidth =  2
        
        userImage2.layer.cornerRadius = userImage2.frame.size.width / 2
        userImage2.clipsToBounds = true
        userImage2.layer.borderColor = UIColor.whiteColor().CGColor
        userImage2.layer.borderWidth =  2
        
        userImage3.layer.cornerRadius = userImage3.frame.size.width / 2
        userImage3.clipsToBounds = true
        userImage3.layer.borderColor = UIColor.blackColor().CGColor
        userImage3.layer.borderWidth =  2
        
        userImage4.layer.cornerRadius = userImage4.frame.size.width / 2
        userImage4.clipsToBounds = true
        userImage4.layer.borderColor = UIColor.whiteColor().CGColor
        userImage4.layer.borderWidth =  2
        
        openGamesLabel.layer.cornerRadius = openGamesLabel.frame.size.width / 2
        openGamesLabel.clipsToBounds = true
        openGamesLabel.layer.borderColor = UIColor.whiteColor().CGColor
        openGamesLabel.layer.borderWidth =  2
        
        if friends.count > 0 {
            pickerSelection = friends[0]
        } else {
            picker.hidden = true
            addOpponentLabel.hidden = true
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "showAlert", userInfo: nil, repeats: false)
        }
        
        let userQuery = PFUser.query()
        let emptyParseObjectArray = [PFObject]()
       
        openCount = 0
        unplayedHistory = emptyParseObjectArray
        unplayedIDs = emptyStringArray
        userQuery.whereKey("objectId", equalTo: currentId)
        
        
        let firstOpponentQuery = PFQuery(className:"GameVS")
        firstOpponentQuery.whereKey("firstOpponent", matchesQuery:userQuery)
        firstOpponentQuery.whereKey("firstOpponentScore", equalTo: NSNull())
        
        let secondOpponentQuery = PFQuery(className:"GameVS")
        secondOpponentQuery.whereKey("secondOpponent", matchesQuery:userQuery)
        secondOpponentQuery.whereKey("secondOpponentScore", equalTo: NSNull())
        
        let thirdOpponentQuery = PFQuery(className:"GameVS")
        thirdOpponentQuery.whereKey("thirdOpponent", matchesQuery:userQuery)
        thirdOpponentQuery.whereKey("thirdOpponentScore", equalTo: NSNull())
        
        let fourthOpponentQuery = PFQuery(className:"GameVS")
        fourthOpponentQuery.whereKey("fourthOpponent", matchesQuery:userQuery)
        fourthOpponentQuery.whereKey("fourthOpponentScore", equalTo: NSNull())
        
        let openGamesQuery = PFQuery.orQueryWithSubqueries ([firstOpponentQuery, secondOpponentQuery, thirdOpponentQuery, fourthOpponentQuery])
        openGamesQuery.orderByDescending("updatedAt")
        openGamesQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    openCount++
                    print("found one")
                    unplayedHistory.append(object as! PFObject)
                    unplayedIDs.append(object.objectId)
                }
            }
            if openCount > 0 {
                self.openGamesLabel.hidden = false
                self.openGamesLabel.text = "\(openCount)"
            }
        }

        
        loadQuizData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return friends.count
    }
    
    //@available(iOS 2.0, *)
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return friends[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelection = friends[row]
    }

    

    func moveUp3rdRow () {
        userImage2.image = userImage3.image
        userName2.text = userName3.text
        
        if userName3.text == "Add Challenger" {
            xbutton2Label.hidden = true
            
        }
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.2), target: self, selector: "moveUpLastRow", userInfo: nil, repeats: false)
    }
    
    func moveUpLastRow () {
        userImage3.image = userImage4.image
        userName3.text = userName4.text
        
        if userName4.text == "Add Challenger" {
            xbutton3Label.hidden = true
            
        }
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.3), target: self, selector: "resetLastRow", userInfo: nil, repeats: false)
    }
    
    func resetLastRow () {
        userName4.text = "Add Challenger"
        userImage4.image = UIImage(named: "challengeicon.png")
        xbutton4Label.hidden = true
    }
    
    func loadQuizData() {
        
        let emptyParseObjectArray = [PFObject]() //used to reset arrays when they take quiz again
        parseObjectArray = emptyParseObjectArray
        
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)

        
        column = "createdAt"
        let men = 0
        let null = NSNull ()
        
        
            let getOutfitQuery = PFQuery(className: "Outfit")
            getOutfitQuery.limit = 100
            getOutfitQuery.orderByDescending(column)
            getOutfitQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        self.challengeObjectIdsBoth.append(object.objectId)
                        
                        if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                            self.outfitImagesBoth.append(imageFile)
                        } else {
                           self.outfitImagesBoth.append(object["outfitImage"] as! PFFile)
                        }

                        if object["fadstirScore"] as? NSNumber == nil {
                            self.outfitFadScoresBoth.append(0)
                        } else {
                            self.outfitFadScoresBoth.append(object["fadstirScore"] as! NSNumber)
                        }
                        if object["fadstirGameAverage"] as? NSNumber == nil {
                            self.outfitGameAverageBoth.append(0)
                        } else {
                            self.outfitGameAverageBoth.append(object["fadstirGameAverage"] as! NSNumber)
                        }
                        if object["fadstirGameViews"] as? NSNumber == nil {
                            self.outfitGameViewsBoth.append(0)
                        } else {
                            self.outfitGameViewsBoth.append(object["fadstirGameViews"] as! NSNumber)
                        }
                        
                        
                        if object["gender"] as! Int == men {
                            self.challengeObjectIdsMen.append(object.objectId)
                            if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                                self.outfitImagesMen.append(imageFile)
                            } else {
                                self.outfitImagesMen.append(object["outfitImage"] as! PFFile)
                            }
                            if object["fadstirScore"] as? NSNumber == nil {
                                self.outfitFadScoresMen.append(0)
                            } else {
                            self.outfitFadScoresMen.append(object["fadstirScore"] as! NSNumber)
                            }
                            if object["fadstirGameAverage"] as? NSNumber == nil {
                                self.outfitGameAverageMen.append(0)
                            } else {
                                self.outfitGameAverageMen.append(object["fadstirGameAverage"] as! NSNumber)
                            }
                            if object["fadstirGameViews"] as? NSNumber == nil {
                                self.outfitGameViewsMen.append(0)
                            } else {
                                self.outfitGameViewsMen.append(object["fadstirGameViews"] as! NSNumber)
                            }
                            
                        } else {
                            self.challengeObjectIdsWomen.append(object.objectId)
                            if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                                self.outfitImagesWomen.append(imageFile)
                            } else {
                                self.outfitImagesWomen.append(object["outfitImage"] as! PFFile)
                            }
                            if object["fadstirScore"] as? NSNumber == nil {
                                self.outfitFadScoresWomen.append(0)
                            } else {
                                self.outfitFadScoresWomen.append(object["fadstirScore"] as! NSNumber)
                            }
                            if object["fadstirGameAverage"] as? NSNumber == nil {
                                self.outfitGameAverageWomen.append(0)
                            } else {
                                self.outfitGameAverageWomen.append(object["fadstirGameAverage"] as! NSNumber)
                            }
                            if object["fadstirGameViews"] as? NSNumber == nil {
                                self.outfitGameViewsWomen.append(0)
                            } else {
                                self.outfitGameViewsWomen.append(object["fadstirGameViews"] as! NSNumber)
                            }
                            
                        }
                    }
                }
                
            }
    
    }

    
    func startGame() {
        activityIndicator.stopAnimating()
        print (challengeObjectIdsBoth.count)
        print(challengeObjectIdsMen.count)
        print (challengeObjectIdsWomen.count)
        print(outfitImagesBoth.count)
        print (outfitImagesMen.count)
        print (outfitImagesWomen.count)
        print (outfitFadScoresBoth.count)
        print (outfitFadScoresMen.count)
        print (outfitFadScoresWomen.count)
        print (outfitGameAverageBoth.count)
        print (outfitGameAverageMen.count)
        print (outfitGameViewsBoth.count)
        print (outfitGameViewsWomen.count)
    
        
        let secondViewController = ChallengePlayViewController(nibName:"ChallengePlayViewController", bundle: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        if openCount > 0 {
            self.openGamesLabel.hidden = false
            self.openGamesLabel.text = "\(openCount)"
        }
    }
    func goToHistory() {
        activityIndicator.stopAnimating()
        let secondViewController = HistoryViewController(nibName:"HistoryViewController", bundle: nil)
        self.navigationController?.pushViewController(secondViewController, animated: true)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    func showAlert(){
        
        let title = "You need more followers"
        
        let alertController = UIAlertController(title: title, message: "You need at least one follower who you can play against.  Send friends a challenge with the blue link", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @available(iOS 8.0, *)
    func showAlert2(){
        
        let title = "Need Opponents"
        
        let alertController = UIAlertController(title: title, message: "You need at least one opponent to start a match", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
