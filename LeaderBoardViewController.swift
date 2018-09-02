//
//  LeaderBoardViewController.swift
// Fd
//
//  Created by Eman I on 1/8/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class LeaderBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.popToRootViewControllerAnimated(true)
//         self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    var readyToStart = false
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   
    
    @IBOutlet var tableView: UITableView!
    var tableData = ["num1", "numer2", "numer3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let nib = UINib(nibName: "LeaderBCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaderBoardInfo.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        //cell.textLabel?.text = historyTableText[indexPath.row]
        
        let cell: LeaderBoardCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! LeaderBoardCell
        let playerInfo = leaderBoardInfo[indexPath.row]
        cell.username.text = playerInfo["username"] as? String
        cell.userScore.text = "\(playerInfo["gamificationScore"] as! NSNumber)"
        cell.userScore.backgroundColor = UIColor.init(red: 18/255.0, green: 122/255.0, blue: 132/255.0, alpha: 1.0)
        
        
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
