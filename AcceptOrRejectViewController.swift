//
//  AcceptOrRejectViewController.swift
// Fd
//
//  Created by Eman I on 1/1/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class AcceptOrRejectViewController: UIViewController {

    @IBOutlet var challengeLabel: UILabel!
    var count = 5
    var questionCount = 0
    let score = 00
    let timer = NSTimer()
    @IBAction func acceptButton(sender: AnyObject) {
       
        let emptyStringArray = [String]()
        let emptyNSNumberArray = [NSNumber]()
        let emptyPFFileArray = [PFFile]()
        let emptyIntArray = [Int]()
        tenChallengeIds = emptyStringArray
        outfitImages = emptyPFFileArray
        outfitFadScores = emptyNSNumberArray
        questionIndex = emptyIntArray
        challengeObjectIds = emptyStringArray
        players = emptyStringArray
        outfitGameAverage = emptyNSNumberArray
        outfitGameViews = emptyNSNumberArray
        
        
        // load 10 images and fadstir scores into local img array and local fadscore array
        
        //placeholder Image
        let imageData = UIImagePNGRepresentation(UIImage(named: "logo@2x.png")!)
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        
        
        let null = NSNull ()
        
        let tenIdsQuery = PFQuery(className: "GameVS")
        tenIdsQuery.getObjectInBackgroundWithId(gameVSId) { (object, error) -> Void in
            if let object = object {
                tenChallengeIds = object["challengeIds"] as! [String]
                players = object["allPlayers"] as! [String]
                
                let outfitQuery = PFQuery(className: "Outfit")
                outfitQuery.whereKey("objectId", containedIn: tenChallengeIds)
                outfitQuery.findObjectsInBackgroundWithBlock{ (objects, error) -> Void in
                        if let objects = objects {
                             for object in objects {
                                questionIndex.append(self.questionCount)
                                challengeObjectIds.append(object.objectId as String)
                            if object["outfitImage"]! == nil || object["outfitImage"]!!.isEqual(null) {
                                outfitImages.append(imageFile)
                                self.questionCount++
                            } else {
                                outfitImages.append(object["outfitImage"] as! PFFile)
                                self.questionCount++
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
        }
            countdownLabel.hidden = false
            tenChallengeIds = challengeObjectIds
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: "startGame", userInfo: nil, repeats: false)
    }

        
        
    
    @IBAction func rejectButton(sender: AnyObject) {
        // go back to notifications - dismiss view controller
        // give score of "00"
        
        let scoreQuery = PFQuery(className:"GameVS")
        scoreQuery.getObjectInBackgroundWithId(gameVSId) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = gameScore {
                //test this
                var didWorkCount = 0
                if gameScore["startPlayer"] != nil && !(gameScore["startPlayer"]!.isEqual(NSNull())) {
                if currentId == gameScore["startPlayer"].objectId as String{
                    gameScore["startPlayerScore"] = self.score as NSNumber
                    didWorkCount++
                    }}
                if gameScore["firstOpponent"] != nil && !(gameScore["firstOpponent"]!.isEqual(NSNull())) {
                if currentId == gameScore["firstOpponent"].objectId as String{
                    gameScore["firstOpponentScore"] = self.score as NSNumber
                    didWorkCount++
                    }}
                if gameScore["secondOpponent"] != nil && !(gameScore["secondOpponent"]!.isEqual(NSNull())) {
                if currentId == gameScore["secondOpponent"].objectId as String{
                    gameScore["secondOpponentScore"] = self.score as NSNumber
                    didWorkCount++
                    }}
                if gameScore["thirdOpponent"] != nil && !(gameScore["thirdOpponent"]!.isEqual(NSNull())) {
                if currentId == gameScore["thirdOpponent"].objectId as String{
                    gameScore["thirdOpponentScore"] = self.score as NSNumber
                    didWorkCount++
                    }}
                if gameScore["fourthOpponent"] != nil && !(gameScore["fourthOpponent"]!.isEqual(NSNull())) {
                if currentId == gameScore["fourthOpponent"].objectId as String{
                    gameScore["fourthOpponentScore"] = self.score as NSNumber
                    didWorkCount++
                    }}
                if didWorkCount == 0 {print ("didn't work for anyone")}
                
                gameScore.saveInBackground()
            
            }
            //self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    @IBOutlet var countdownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownLabel.hidden = true
        // Do any additional setup after loading the view.
        let emptyStringArray = [String]()
        playersUsernames = emptyStringArray
        
        let gameQuery = PFQuery(className: "GameVS")
        gameQuery.getObjectInBackgroundWithId(gameVSId) { (object, error) -> Void in
            if let object = object {
                let array = object["allPlayers"] as! [String]
        let userQuery = PFUser.query()
        userQuery.whereKey("objectId", containedIn: array)
        userQuery.findObjectsInBackgroundWithBlock{ (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    playersUsernames.append(object["username"] as! String)
                    print("this is the user \(object["username"] as! String)")
                }
                var label = "The field has been set: "
                for var j = 0; j < playersUsernames.count; j++ {
                   
                    if j == 0 {
                        label += "\(playersUsernames[j])"
                    } else {
                    label += " VS \(playersUsernames[j])"
                    }
                }
                label += ".  Do you accept?"
                self.challengeLabel.text = label
            }
          }
        }
      }
    }
    
    func startGame() {
        print(tenChallengeIds)
        print(challengeObjectIds)
        print(outfitFadScores.count)
        print(outfitImages.count)
        print(questionIndex)
        let secondViewController = ChallengePlayViewController(nibName:"ChallengePlayViewController", bundle: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(secondViewController, animated: false)
        //self.presentViewController(secondViewController, animated: true, completion: nil)

      
        }
        
    func update() {
        
        if(count > 0)
            {
                count--
                countdownLabel.text = "\(count)"
            }
            
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
