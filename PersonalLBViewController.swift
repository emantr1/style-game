//
//  LeaderBoardViewController.swift
// Fd
//
//  Created by Eman I on 1/8/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class PersonalLBViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //        self.navigationController?.popToRootViewControllerAnimated(true)
        //         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func appBoard(sender: AnyObject) {
        
        //make sure to pull on 3 columns -  name - score - photo
        let leaderBoardQ = PFUser.query()
        let leaderBoardEmpty = [PFObject]()
        leaderBoardInfo = leaderBoardEmpty
        leaderBoardQ.orderByDescending("gamificationScore")
        leaderBoardQ.limit = 20
        leaderBoardQ.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    leaderBoardInfo.append(object as! PFObject)
                }
            }
            let secondViewController = LeaderBoardViewController(nibName:"LeaderBoardViewController", bundle: nil)
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
            
        }
        
    }
    
    
    @IBOutlet var tableView: UITableView!
    var tableData = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = personalLB

        
        
        
        let nib = UINib(nibName: "LeaderBCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return personalLB.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print(tableData)
        
        
        let cell: LeaderBoardCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! LeaderBoardCell
        let playerInfo = personalLB[indexPath.row]
        cell.username?.text = playerInfo["username"] as? String
        
        if playerInfo["gamificationScore"] != nil {
        cell.userScore.text = "\(playerInfo["gamificationScore"] as! NSNumber)"
        } else {
            cell.userScore.text = "0"
        }
        
        
        if playerInfo["userPhoto"] != nil && !(playerInfo["userPhoto"].isEqual(NSNull())) {
            let image = playerInfo["userPhoto"] as! PFFile
            image.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    if let downloadedImage = UIImage(data: data!) {
                        cell.userImage.image = downloadedImage
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("row \(indexPath.row) selected")
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
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
