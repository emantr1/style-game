//
//  HomeGameViewController.swift
// Fd
//
//  Created by Eman I on 11/23/15.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit
//import Parse
import AVFoundation

@available(iOS 8.0, *)
class HomeGameViewController: UIViewController {

    
        @IBOutlet var highscoreLabel: UILabel!
    @IBAction func playButton(sender: UIButton) {
  //      let secondViewController = ViewController(nibName:"GameViewController", bundle: nil)
      //  self.presentViewController(secondViewController, animated: true, completion: nil)
    }
        @IBOutlet var scoreLabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            view.backgroundColor = UIColor(red: 232/255.0, green: 240/255.0, blue: 243/255.0, alpha: 1.0)
            
           
           
        }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
            
           
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func loadQuizData() {
            //Image Quiz Data
            //let pathIQ = NSBundle.mainBundle().pathForResource("ImageQuiz", ofType: "plist")
            //let dictIQ = NSDictionary(contentsOfFile: pathIQ!)
           // imgArray = dictIQ!["Questions"]!.mutableCopy() as? Array
            
            let getOutfitQuery = PFQuery(className: "Outfit")
            getOutfitQuery.limit = 50
            getOutfitQuery.orderByDescending("numberOfViews")
            getOutfitQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        parseObjectArray.append(object as! PFObject)
                    }
                }
            }
        }
        
        func check() {
            
            
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


