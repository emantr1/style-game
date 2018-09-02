//
//  GameTestViewController.swift
// Fd
//
//  Created by Eman I on 11/23/15.
//  Copyright © 2016 Eman. All rights reserved.
//



import UIKit
import AVFoundation

@available(iOS 8.0, *)
class GameTestViewController: UIViewController {
        var player:AVAudioPlayer = AVAudioPlayer()
        var type = 0
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        @IBOutlet var highscoreLabel: UILabel!
        var columnToFilter:[String] = ["numberOfViews", "fadstirScore", "createdAt"]
        var column = "numberOfViews"
    
    @IBAction func viewLeaderBoard(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.highscoreLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        //activityIndicator.color = UIColor.blackColor()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //reset arrays
        let leaderBoardEmpty = [PFObject]()
        personalLB = leaderBoardEmpty
        
        //follower
        let getFollowersQuery = PFQuery(className: "FollowUsersMap")
        getFollowersQuery.includeKey("fromUser")
        
        let userQuery = PFUser.query()
        userQuery.whereKey("objectId", equalTo: currentId)
        getFollowersQuery.whereKey("fromUser", matchesQuery:userQuery)
        getFollowersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                var objCount = objects.count
                
                if objCount == 0 {self.goToView()}
                for object in objects {
                    
                    //test this--
                    if object["toUser"]! != nil && !(object["toUser"]!!.isEqual(NSNull())) {
                        //let follower = object["toUser"]
                        
                        let user : PFUser = object["toUser"] as! PFUser
                        
                        let queryUsers = PFUser.query()
                        queryUsers.getObjectInBackgroundWithId(user.objectId, block: { (userGet :PFObject!,error : NSError!) -> Void in
                           personalLB.append(userGet)
                            objCount--
                            if objCount == 0 {
                                self.goToView()
                            }

                            
                        })
                        

                        //let user = PFQuery.getUserObjectWithId(follower!!.objectId as String)
                        //personalLB.append(user)
                        
                        if objCount == 0 {
                            self.goToView()
                        }
                    }
                }
            } else {
                self.goToView()
            }
            
        }

       
    }
    
    func goToView() {
        personalLB.append(PFUser.currentUser())
        if personalLB.count > 1 {
            let sortedArray = personalLB.sort { Int(($0["gamificationScore"] as? NSNumber)!) > Int(($1["gamificationScore"] as? NSNumber)!) }
            personalLB = sortedArray
        }
        let secondViewController = PersonalLBViewController(nibName:"PersonalLBViewController", bundle: nil)
        self.navigationController?.pushViewController(secondViewController, animated: true)
        activityIndicator.stopAnimating()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

        @IBAction func playButton(sender: UIButton) {
        //button under the icons - in case want to use for something
        }
       //@IBOutlet var scoreLabel: UILabel!
    @IBAction func playMen(sender: UIButton) {
        type = 0
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.highscoreLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "startGame", userInfo: nil, repeats: false)
    }
    @IBAction func playBoth(sender: UIButton) {
        type = 5
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.highscoreLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "startGame", userInfo: nil, repeats: false)

    }
    @IBAction func playWomen(sender: UIButton) {
        type = 2
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.highscoreLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "startGame", userInfo: nil, repeats: false)
    }
    
    
    @IBOutlet var vsCircle: UIImageView!
    @IBOutlet var vsButton: UIButton!
   
    @IBAction func playVS(sender: AnyObject) {
        let secondViewController = ChallengeStartViewController(nibName:"ChallengeStartViewController", bundle: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            view.backgroundColor = UIColor(red: 232/255.0, green: 240/255.0, blue: 243/255.0, alpha: 1.0)
            currentId = PFUser.currentUser().objectId
            //PFCloud.callFunction("incrementGamesPlayed", withParameters: ["userId" : currentId], error: ())
            
           
            
            /*PFCloud.callFunctionInBackground("incrementFadstirGameViews", withParameters: ["outfitId": "1W0zSvBcqD"]) {
                (ratings, error) in
                if (error == nil) {
                    print(ratings)
                    // ratings is 4.5
                }
            }
            
            PFCloud.callFunctionInBackground("updateFadstirGameAverage", withParameters: ["outfitId": "1W0zSvBcqD", "gameAverage": 45]) {
                (ratings, error) in
                if (error == nil) {
                    print(ratings)
                    // ratings is 4.5
                }
            }*/
         

            
            let correctSound = NSBundle.mainBundle().pathForResource("introgame", ofType: "mp3")
            
            do {
                player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: correctSound!))
                
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
            }
            catch {
                print("Something bad happened. Try catching specific errors to narrow things down")
            }
            
            player.play()
             NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "rotateVS" , userInfo: nil, repeats: false)
            loadFriends()
            //seenOutfits = newOutfits //--------------------------------------------
           
        }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
            
        /*PFCloud.callFunctionInBackground("incrementGamesPlayed", withParameters: ["userId": currentId]) {
                (ratings, error) in
                if (error == nil) {
                    print(error)
                    // ratings is 4.5
                }
            }*/
        navigationController?.setNavigationBarHidden(true, animated: false)
            
           
            let highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
            //scoreLabel.text = "Score: \(score)"
            highscoreLabel.text = "High Score: \(highscore)"
             //vsButton.hidden = true
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    func loadQuizData(gender: Int) {
       
        
        let emptyParseObjectArray = [PFObject]() //used to reset arrays when they take quiz again
        let emptyAnyObjectArray =  [AnyObject]()
        let emptyPF = [PFFile]()
        let emptyNSNumber = [NSNumber]()
        let emptyString = [String]()
        newOutfits = emptyAnyObjectArray
        triviaObjectArray = emptyParseObjectArray
        parseObjectArray = emptyParseObjectArray
        outfitImages = emptyPF
        outfitFadScores = emptyNSNumber
        outfitObjectIds = emptyString
        outfitGameViews = emptyNSNumber
        outfitGameAverage = emptyNSNumber
        
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        // get trivia questions
        let getTriviaQuery = PFQuery(className: "Trivia")
        getTriviaQuery.limit = 100
        getTriviaQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    triviaObjectArray.append(object as! PFObject)
                }
            }
        }
        //let columnNum = Int(arc4random_uniform(UInt32(columnToFilter.count)))
        //column = columnToFilter[columnNum]
        column = "createdAt"
        let null = NSNull ()
        
        if gender == 0 || gender == 2 {
           
            let getOutfitQuery2 = PFQuery(className: "Outfit")
            if seenOutfits != nil {
                getOutfitQuery2.whereKey("objectId" as String, notContainedIn: seenOutfits as! [String])
            }
            getOutfitQuery2.limit = 100
            getOutfitQuery2.orderByDescending(column)
            getOutfitQuery2.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        if object["gender"]! != nil {
                        if object["gender"] as! Int == gender {
                            //parseObjectArray2.append(object as! PFObject)
                            outfitObjectIds.append(object.objectId as String)
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
                        }
                    }
                }
                self.startGame()
            }
        } else {
            let getOutfitQuery2 = PFQuery(className: "Outfit")
            if seenOutfits != nil {
                getOutfitQuery2.whereKey("objectId" as String, notContainedIn: seenOutfits as! [String])
            }
            getOutfitQuery2.limit = 100
            getOutfitQuery2.orderByDescending(column)
            getOutfitQuery2.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        //parseObjectArray2.append(object as! PFObject)
                        outfitObjectIds.append(object.objectId as String)
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
                }
                self.startGame()
            }
            
            }
        
      
    }
        
    
        func startGame() {
            print("this is how many outfits are in the object array\(parseObjectArray.count)")
            parseObjectArray = parseObjectArray + parseObjectArray2
            parseObjectArray.shuffle()
            print("this is how many outfits are int he object arry now \(parseObjectArray.count)")
           
            // get random #s to use for array index for game
            var randQuestions = [Int]()
            for var i = 0; randQuestions.count < outfitObjectIds.count - 1; i++ {
                let count = Int(arc4random_uniform(UInt32(outfitObjectIds.count - 1)))
                if !randQuestions.contains(count) {
                    randQuestions.append(count)
                }
            }
            questionIndex = randQuestions
            print ("this is the question index count \(questionIndex.count) this is the objectId count \(outfitObjectIds.count)")
            activityIndicator.stopAnimating()
            let secondViewController = GameViewController(nibName:"GameViewController", bundle: nil)
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
            self.navigationController?.pushViewController(secondViewController, animated: false)
            //self.presentViewController(secondViewController, animated: true, completion: nil)
            
        }
    
    func rotateVS () {
        UIView.animateWithDuration(15.0, animations: {
            self.vsCircle.transform = CGAffineTransformMakeRotation((CGFloat(M_PI)))
        })
        UIView.animateWithDuration(15.0, animations: {
            self.vsCircle.transform = CGAffineTransformMakeRotation( 0.0 * (CGFloat(M_PI)) / 180.0)
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @available(iOS 8.0, *)
    func showAlert(){
        
        let title = "You need more followers"
        
        let alertController = UIAlertController(title: title, message: "You got to have more followers", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadFriends () {
        //reset arrays
        let emptyfriends = [String]()
        let emptyImages = [PFFile]()
        friendIds = emptyfriends
        friends = emptyfriends
        friendImages = emptyImages
        
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "statusIcon.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)
        //follower
        
        let getFollowersQuery = PFQuery(className: "FollowUsersMap")
        getFollowersQuery.includeKey("toUser")
        
        let userQuery = PFUser.query()
        userQuery.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
        getFollowersQuery.whereKey("toUser", matchesQuery:userQuery)
        getFollowersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    //test this--  
                    if object["fromUser"]! != nil && !(object["fromUser"]!!.isEqual(NSNull())) {
                    let follower = object["fromUser"]
                    
                    let query = PFUser.query()
                    query.whereKey("objectId", equalTo: follower!!.objectId as String)
                    query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                        if let objects = objects {
                            for object in objects {
                                friendObjects.append(object as! PFObject)
                                friends.append(object["username"] as! String)
                                friendIds.append(follower!!.objectId)

                                if object["userPhoto"]! == nil || object["userPhoto"]!!.isEqual(NSNull()) {
                                    
                                    friendImages.append(imageFile)
                                } else {
                                    friendImages.append(object["userPhoto"] as! PFFile)
                                }
                            }
                            
                        }
                        
                    })
                  }
                }
            }
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
