//
//  PopUpViewController.swift
//Fd
//
//  Created by Eman I on 12/26/15.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit
import MessageUI
import Social

@available(iOS 8.0, *)
class PopUpViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBAction func twitterSelected(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let TwitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            TwitterSheet.setInitialText("Hey join me on Fadstir so I can beat you at this game ;)         https://itunes.apple.com/us/app/apple-store/id978283382?pt=117726361&ct=inside&mt=8")
            self.presentViewController(TwitterSheet, animated: true, completion: nil)
        } else {
            
            let alert = UIAlertController(title: "Account", message: "Please log into your Twitter account to post", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    @IBAction func facebookSelected(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let FB:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            FB.setInitialText("Hey join me on Fadstir so I can beat you at this game ;)         https://itunes.apple.com/us/app/apple-store/id978283382?pt=117726361&ct=inside&mt=8")
            self.presentViewController(FB, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Account", message: "Please log into your Facebook account to post", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        }
        
    }
    @IBAction func textMessageSelected(sender: AnyObject) {
        
        let messageVC = MFMessageComposeViewController ()
        messageVC.body = "Hey join me on Fadstir so I can beat you at this game ;)         https://itunes.apple.com/us/app/apple-store/id978283382?pt=117726361&ct=inside&mt=8"
        messageVC.messageComposeDelegate = self
        self.presentViewController(messageVC, animated: true, completion: nil)

    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print ("Message canceled")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultFailed.rawValue:
            print ("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultSent.rawValue:
            print ("Message sent")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
