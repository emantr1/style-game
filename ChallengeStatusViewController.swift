//
//  ChallengeStatusViewController.swift
//Fd
//
//  Created by Eman I on 12/26/15.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class ChallengeStatusViewController: UIViewController {

    @IBOutlet var firstPlaceLabel: UILabel!
    @IBOutlet var firstPlaceImage: UIImageView!
    @IBOutlet var firstPlaceUsername: UILabel!
    @IBOutlet var firstPlaceScore: UILabel!
    @IBOutlet var secondPlaceLabel: UILabel!
    @IBOutlet var secondPlaceImage: UIImageView!
    @IBOutlet var secondPlaceUsername: UILabel!
    @IBOutlet var secondPlaceScore: UILabel!
    @IBOutlet var thirdPlaceLabel: UILabel!
    @IBOutlet var thirdPlaceImage: UIImageView!
    @IBOutlet var thirdPlaceUsername: UILabel!
    @IBOutlet var thirdPlaceScore: UILabel!
    @IBOutlet var fourthPlaceLabel: UILabel!
    @IBOutlet var fourthPlaceImage: UIImageView!
    @IBOutlet var fourthPlaceUsername: UILabel!
    @IBOutlet var fourthPlaceScore: UILabel!
    @IBOutlet var fifthPlaceImage: UIImageView!
    @IBOutlet var fifthPlaceUsername: UILabel!
    @IBOutlet var fifthPlaceScore: UILabel!
    @IBOutlet var fifthPlaceLabel: UILabel!
    var playerOrder = ["first", "second", "third", "fourth"]
    var opponentsObjects = [PFObject]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var backLabel: UIButton!
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var currentUserPhoto = PFFile()
    
    @IBAction func playMen(sender: AnyObject) {
        if opponentsObjects.count > 1 {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.fifthPlaceUsername.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        loadQuizData(0)
        } else {
                showAlert2()
                print ("need at least one opponent")
            }
    }
    @IBAction func playBoth(sender: AnyObject) {
        if opponentsObjects.count > 1 {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
            activityIndicator.center = self.fifthPlaceUsername.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            loadQuizData(3)
        } else {
            showAlert2()
            print ("need at least one opponent")
        }

    }
    @IBAction func playWomen(sender: AnyObject) {
        if opponentsObjects.count > 1 {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
            activityIndicator.center = self.fifthPlaceUsername.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            loadQuizData(2)
        } else {
            showAlert2()
            print ("need at least one opponent")
        }

    }
    @IBAction func goHome(sender: AnyObject) {
        comingFromGame = false
        //let secondViewController = ChallengeStartViewController(nibName:"ChallengeStartViewController", bundle: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
        //self.presentViewController(secondViewController, animated: true, completion: nil)

    }
    var userObjects =  [[AnyObject]]()
    let emptyMultiArray = [[AnyObject]]()
    var scoresCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if comingFromGame == true {backLabel.hidden = true}
        
        firstPlaceImage.layer.cornerRadius = firstPlaceImage.frame.size.width / 2
        firstPlaceImage.clipsToBounds = true

        secondPlaceImage.layer.cornerRadius = secondPlaceImage.frame.size.width / 2
        secondPlaceImage.clipsToBounds = true

        thirdPlaceImage.layer.cornerRadius = thirdPlaceImage.frame.size.width / 2
        thirdPlaceImage.clipsToBounds = true

        fourthPlaceImage.layer.cornerRadius = fourthPlaceImage.frame.size.width / 2
        fourthPlaceImage.clipsToBounds = true

        fifthPlaceImage.layer.cornerRadius = fifthPlaceImage.frame.size.width / 2
        fifthPlaceImage.clipsToBounds = true
 
        // Do any additional setup after loading the view.
       
        //need to pull parse scores
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)
        let null = NSNull ()
        
        let scoreQuery = PFQuery(className:"GameVS")
        scoreQuery.getObjectInBackgroundWithId(gameVSId) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = gameScore {
                let userQ = PFUser.query()
                
                    self.userObjects = self.emptyMultiArray
                    print("these are players before query \(players)")
                    userQ.whereKey("objectId", containedIn: players)
                    userQ.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                        if let objects = objects {
                            for object in objects {
                                if object.objectId != PFUser.currentUser().objectId {
                                    self.opponentsObjects.append(object as! PFObject)}
                                var currentUserObject = [AnyObject]()
                                //add ID to AnyObject local
                                currentUserObject.append(object.objectId as String)
                                // add username to AnyObject local
                                currentUserObject.append(object["username"] as! String)
                                
                                //find the photo - add to AnyObject local
                                if object["userPhoto"]! == nil || object["userPhoto"]!!.isEqual(null) {
                                    
                                    currentUserObject.append(imageFile)
                                } else {
                                    currentUserObject.append(object["userPhoto"] as! PFFile)
                                }
                // find the scores and add to local Anyobject
                    print("lookcing for id \(object.objectId as String)")
                if object.objectId == gameScore["startPlayer"].objectId as String{
                    if gameScore["startPlayerScore"] as? NSNumber == nil {
                        currentUserObject.append(0)
                    } else {
                        currentUserObject.append(gameScore["startPlayerScore"] as! NSNumber)
                        self.scoresCount++
                    }
                } else if gameScore["firstOpponent"] != nil && object.objectId == gameScore["firstOpponent"].objectId as String{
                    if gameScore["firstOpponentScore"] as? NSNumber == nil {
                        currentUserObject.append(0)
                    } else {
                        currentUserObject.append(gameScore["firstOpponentScore"] as! NSNumber)
                        self.scoresCount++
                    }
                } else if gameScore["secondOpponent"] != nil && object.objectId == gameScore["secondOpponent"].objectId as String{
                    if gameScore["secondOpponentScore"] as? NSNumber == nil {
                        currentUserObject.append(0)
                    } else {
                        currentUserObject.append(gameScore["secondOpponentScore"] as! NSNumber)
                        self.scoresCount++
                    }
                } else if gameScore["thirdOpponent"] != nil && object.objectId == gameScore["thirdOpponent"].objectId as String{
                    if gameScore["thirdOpponentScore"] as? NSNumber == nil {
                        currentUserObject.append(0)
                    } else {
                        currentUserObject.append(gameScore["thirdOpponentScore"] as! NSNumber)
                        self.scoresCount++
                    }
                } else if gameScore["fourthOpponent"] != nil && object.objectId == gameScore["fourthOpponent"].objectId as String{
                    if gameScore["fourthOpponentScore"] as? NSNumber == nil {
                        currentUserObject.append(0)
                    } else {
                        currentUserObject.append(gameScore["fourthOpponentScore"] as! NSNumber)
                        self.scoresCount++
                    }
                } else {
                    print ("didn't work for \(object.objectId as String) for game \(gameVSId)")
                    currentUserObject.append(0)
                }
                    self.userObjects.append(currentUserObject)
                            }
                            if self.scoresCount == players.count {gameScore["gameDone"] = true}
                            gameScore.saveInBackground()
                            self.addToView()
                        }
                        
                    })
            }
      }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuizData(gender: Int) {
        
        let emptyParseObjectArray = [PFObject]() //used to reset arrays when they take quiz again
        let emptyStringArray = [String]()
        let emptyNumArray = [NSNumber]()
        let emptyImgArray = [PFFile]()
        parseObjectArray = emptyParseObjectArray
        challengeObjectIds = emptyStringArray
        outfitImages = emptyImgArray
        outfitFadScores = emptyNumArray
        outfitGameAverage = emptyNumArray
        outfitGameViews = emptyNumArray
    
     

        
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        
        let column = "createdAt"
        //let men = 0
        let null = NSNull ()
        
        
        let getOutfitQuery = PFQuery(className: "Outfit")
        getOutfitQuery.limit = 100
        getOutfitQuery.orderByDescending(column)
        getOutfitQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                var objCount = objects.count
                for object in objects {
                    if gender == 3{
                    challengeObjectIds.append(object.objectId)
                    
                    if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                        outfitImages.append(imageFile)
                    } else {
                        outfitImages.append(object["outfitImage"] as! PFFile)
                    }
                    
                    if object["fadstirScore"] as? NSNumber == nil {
                        outfitFadScores.append(0)
                    } else {
                        outfitFadScores.append(object["fadstirScore"] as! NSNumber)
                    }
                    if object["fadstirGameAverage"] as? NSNumber == nil {
                        outfitGameAverage.append(0)
                    } else {
                        outfitGameAverage.append(object["fadstirGameAverage"] as! NSNumber)
                    }
                    if object["fadstirGameViews"] as? NSNumber == nil {
                        outfitGameViews.append(0)
                    } else {
                        outfitGameViews.append(object["fadstirGameViews"] as! NSNumber)
                    }
                     objCount--
                        if objCount == 0 {self.nextStep()}
                    } else{
                    if object["gender"] as! Int == gender {
                        challengeObjectIds.append(object.objectId)
                        if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                            outfitImages.append(imageFile)
                        } else {
                            outfitImages.append(object["outfitImage"] as! PFFile)
                        }
                        if object["fadstirScore"] as? NSNumber == nil {
                            outfitFadScores.append(0)
                        } else {
                            outfitFadScores.append(object["fadstirScore"] as! NSNumber)
                        }
                        if object["fadstirGameAverage"] as? NSNumber == nil {
                            outfitGameAverage.append(0)
                        } else {
                            outfitGameAverage.append(object["fadstirGameAverage"] as! NSNumber)
                        }
                        if object["fadstirGameViews"] as? NSNumber == nil {
                            outfitGameViews.append(0)
                        } else {
                            outfitGameViews.append(object["fadstirGameViews"] as! NSNumber)
                        }
                        
                    }
                      objCount--
                        if objCount == 0 {self.nextStep()}
                    }
                }
            }
            
        }
        
    }
    
    func nextStep() {
            let emptyStringArray = [String]()
            //players = emptyStringArray
            playersUsernames = emptyStringArray
            tenChallengeIds = emptyStringArray
        
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
        
            print("these are opponent IDs \(players)")
            
            //save stuff to parse
            //players.append(currentId)
            let gameVS = PFObject(className:"GameVS")
            gameVS["startPlayer"] = PFUser.currentUser()
            gameVS["allPlayers"] = players
            gameVS["challengeIds"] = tenChallengeIds
            var oppArray = [String]()
        
            for var e = 0; e<opponentsObjects.count; e++ {
                    gameVS["\(playerOrder[e])Opponent"] = opponentsObjects[e]
                    oppArray.append(opponentsObjects[e].objectId)
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
        

    }
    
    func startGame() {
        activityIndicator.stopAnimating()
      
        
        
        let secondViewController = ChallengePlayViewController(nibName:"ChallengePlayViewController", bundle: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
        
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
    
    func addToView() {
        print ("this is total players \(players.count)")
        print("this is userobjects count \(userObjects.count)")
        print("this is the score count\(scoresCount)")
        print(players)
        
        // check how many scores we have it # scores matches # players then gameDone == true
        if userObjects.count <= 2 {
            thirdPlaceImage.hidden = true
            thirdPlaceLabel.hidden = true
            thirdPlaceScore.hidden = true
            thirdPlaceUsername.hidden = true
            fourthPlaceImage.hidden = true
            fourthPlaceLabel.hidden = true
            fourthPlaceScore.hidden = true
            fourthPlaceUsername.hidden = true
            fifthPlaceImage.hidden = true
            fifthPlaceLabel.hidden = true
            fifthPlaceScore.hidden = true
            fifthPlaceUsername.hidden = true
        }
        else if userObjects.count == 3 {
            
            fourthPlaceImage.hidden = true
            fourthPlaceLabel.hidden = true
            fourthPlaceScore.hidden = true
            fourthPlaceUsername.hidden = true
            fifthPlaceImage.hidden = true
            fifthPlaceLabel.hidden = true
            fifthPlaceScore.hidden = true
            fifthPlaceUsername.hidden = true
            
        }
        else if userObjects.count == 4 {
            fifthPlaceImage.hidden = true
            fifthPlaceLabel.hidden = true
            fifthPlaceScore.hidden = true
            fifthPlaceUsername.hidden = true
        }

        
        // ID [0] -- USERNAME [1] -- PHOTO [2] -- SCORE [3]
        if userObjects.count > 1 {
            let sortedArray = userObjects.sort { ($0[3] as? Int) > ($1[3] as? Int) }
            userObjects = sortedArray
        }
        print(userObjects)
        if userObjects.count >= 1 {
            
            userObjects[0][2].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.firstPlaceImage.image = downloadedImage
                }
            }
            
            firstPlaceScore.text = "\(userObjects[0][3])"
            firstPlaceUsername.text = userObjects[0][1] as? String
            secondPlaceUsername.text = "not found" 
        }
        
        if userObjects.count >= 2 {
            userObjects[1][2].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.secondPlaceImage.image = downloadedImage
                }
            }
            secondPlaceScore.text = "\(userObjects[1][3])"
            secondPlaceUsername.text = "\(userObjects[1][1])" 
        }
        
        if userObjects.count >= 3 {
            userObjects[2][2].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.thirdPlaceImage.image = downloadedImage
                }
            }
            thirdPlaceScore.text = "\(userObjects[2][3])"
            thirdPlaceUsername.text = userObjects[2][1] as? String
        }
        
        if userObjects.count >= 4 {
            userObjects[3][2].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.fourthPlaceImage.image = downloadedImage
                }
            }
            fourthPlaceScore.text = "\(userObjects[3][3])"
            fourthPlaceUsername.text = userObjects[3][1] as? String
        }
        
        if userObjects.count >= 5 {
            userObjects[3][2].getDataInBackgroundWithBlock { (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    self.fifthPlaceImage.image = downloadedImage
                }
            }
            fifthPlaceScore.text = "\(userObjects[4][3])"
            fifthPlaceUsername.text = userObjects[4][1] as? String
        }
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
