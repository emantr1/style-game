//
//  StatusViewController.swift
// Fd
//
//  Created by Eman I on 12/5/15.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class StatusViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    var progressImage: UIImage?
    var type = 0
    @IBOutlet var backgroundImage: UIImageView!
    var columnToFilter:[String] = ["numberOfViews", "fadstirScore", "createdAt"]
    var column = "numberOfViews"
    @IBOutlet var bar: UIProgressView!
    @IBAction func playMen(sender: UIButton) {
        type = 0
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.playAgainLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "startGame", userInfo: nil, repeats: false)
    

    }
    @IBOutlet var playAgainLabel: UILabel!
    @IBAction func playBoth(sender: UIButton) {
        type = 5
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.playAgainLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "startGame", userInfo: nil, repeats: false)
        

    }
    @IBAction func playWomen(sender: UIButton) {
        type = 2
        loadQuizData(type)
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.center = self.playAgainLabel.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "startGame", userInfo: nil, repeats: false)
        

    }
    @IBOutlet var statusText: UILabel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        //let secondViewController = GameTestViewController(nibName:"GameTestViewController", bundle: nil)
        //self.presentViewController(secondViewController, animated: true, completion: nil)

    }
    @IBAction func playAgain(sender: UIButton) {
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let score = NSUserDefaults.standardUserDefaults().integerForKey("score")
        var levelNum = 0
       
        if score < 5 {
            bar.progress = 0.1
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you my friend you are hanging with the roots"
        } else if score >= 5 && score < 20 {
            bar.progress = 0.2
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you have a few leaves, but you're still nothing special"
            levelNum = 1
        }
        else if score >= 20 && score < 30 {
            bar.progress = 0.3
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you're getting off the ground a bit, but still have work to do"
            levelNum = 2
        }
        else if score >= 30 && score < 40 {
            bar.progress = 0.4
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you're making good progress"
            levelNum = 3
        }
        else if score >= 40 && score < 50 {
            bar.progress = 0.5
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you're looking pretty good and people are starting to notice"
            levelNum = 4
        }
        else if score >= 50 && score < 60 {
            bar.progress = 0.6
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) your core skills are strong, but now it's time to step it up a bit more"
            levelNum = 5
        }
        else if score >= 60 && score < 70 {
            bar.progress = 0.7
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you're pretty fresh!  Plus you have a few fans ;)"
            levelNum = 6
        }
        else if score >= 70 && score < 80 {
            bar.progress = 0.8
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) there's no denying your precense!  Let me be on your team please!"
            levelNum = 7
        }
        else if score >= 80 && score < 90 {
            bar.progress = 0.85
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you've developed into something incredible.  Your style  is its own category and changes the game!"
            levelNum = 8
        }
        else if score >= 90 && score < 95 {
            bar.progress = 0.9
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) you must work in the industry because your ability is miles ahead of the average person!"
            levelNum = 9
        }
        else if score >= 95 && score < 100 {
            bar.progress = 0.95
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) the beauty, skill and talent you possess leaves us in awe!  You affect people you don't even know."
            levelNum = 10
        }
        else {
            bar.progress = 1.0
            statusText.text = "Developing fashion sense is like growing a tree... and with a score of \(score) You own the fashion world and we're just living in it!  Treat us kindly please."
            levelNum = 100
        }
        print ("This is the user score \(score)")
        backgroundImage.image = UIImage(named:"level\(levelNum).jpg")
        scoreLabel.text = "\(score) pts"
        
        if bar.progress <= 0.2 {
            bar.progressTintColor = UIColor(red: 119/255.0, green: 6/255.0, blue: 0/255.0, alpha: 1.0)
        } else if bar.progress <= 0.4 {
            bar.progressTintColor = UIColor(red: 248/255.0, green: 12/255.0, blue: 0/255.0, alpha: 1.0)
        } else if bar.progress <= 0.6 {
            bar.progressTintColor = UIColor(red: 202/255.0, green: 137/255.0, blue: 0/255.0, alpha: 1.0)
        } else if bar.progress <= 0.8 {
            bar.progressTintColor = UIColor(red: 255/255.0, green: 185/255.0, blue: 36/255.0, alpha: 1.0)
        } else if bar.progress <= 0.9 {
            bar.progressTintColor = UIColor(red: 0/255.0, green: 157/255.0, blue: 19/255.0, alpha: 1.0)
        } else if bar.progress <= 0.95 {
            bar.progressTintColor = UIColor(red: 29/255.0, green: 206/255.0, blue: 51/255.0, alpha: 1.0)
        } else if bar.progress == 1.0 {
            bar.progressTintColor = UIColor(red: 26/255.0, green: 158/255.0, blue: 170/255.0, alpha: 1.0)
        }

        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuizData(gender: Int) {
        
        
        let emptyParseObjectArray = [PFObject]() //used to reset when they take quiz again
        let emptyAnyObjectArray =  [AnyObject]()
        let emptyPF = [PFFile]()
        let emptyNSNumber = [NSNumber]()
        let emptyString = [String]()
        newOutfits = emptyAnyObjectArray
        triviaObjectArray = emptyParseObjectArray
        parseObjectArray = emptyParseObjectArray
        parseObjectArray2 = emptyParseObjectArray
        outfitImages = emptyPF
        outfitFadScores = emptyNSNumber
        outfitObjectIds = emptyString
        outfitGameAverage = emptyNSNumber
        outfitGameViews = emptyNSNumber
        let null = NSNull ()
        
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
        
        if gender == 0 || gender == 2 {
            print("This is the gender we want -- \(gender) should be male or female")
            
            let getOutfitQuery2 = PFQuery(className: "Outfit")
            if seenOutfits != nil {
                getOutfitQuery2.whereKey("objectId" as String, notContainedIn: seenOutfits as! [String])
            }
            getOutfitQuery2.limit = 100
            getOutfitQuery2.orderByDescending(column)
            getOutfitQuery2.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        if object["gender"] as! Int == gender {
                            
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
                self.startGame()
            }
        } else {
            print("This is the gender we want -- \(gender) should be combo")
            
            let getOutfitQuery2 = PFQuery(className: "Outfit")
            if seenOutfits != nil {
                getOutfitQuery2.whereKey("objectId" as String, notContainedIn: seenOutfits as! [String])
            }
            getOutfitQuery2.limit = 100
            getOutfitQuery2.orderByDescending(column)
            getOutfitQuery2.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        
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
        
        let secondViewController = GameViewController(nibName:"GameViewController", bundle: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
        
        
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
