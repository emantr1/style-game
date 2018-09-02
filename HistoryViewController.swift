//
//  HistoryViewController.swift
// Fd
//
//  Created by Eman I on 1/4/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        openCount = 0
        
        let userQuery = PFUser.query()
        let emptyParseObjectArray = [PFObject]()
        let emptyStringArray = [String]()
        
        
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
        }
    }
   
    @IBOutlet var tableView: UITableView!
    var tableData = ["num1", "numer2", "numer3"]
    var refresher: UIRefreshControl!
    
    func refresh() {
        
       
        let userQuery = PFUser.query()
        let emptyParseObjectArray = [PFObject]()
        let emptyStringArray = [String]()
        
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
        }
        self.tableView.reloadData()
        let nib = UINib(nibName: "viewTblCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        self.refresher.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)

       

        let nib = UINib(nibName: "viewTblCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTableText.count
       
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        //cell.textLabel?.text = historyTableText[indexPath.row]
        
        let cell: TblCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! TblCell
        cell.dateLabel.text = historyTableText[indexPath.row]
        if historyOpponentCount[indexPath.row] > 2 {
        cell.gameLabel.text = "\(historyOpponentCount[indexPath.row] - 1) friends!"
        } else {
             cell.gameLabel.text = "\(historyOpponentCount[indexPath.row] - 1) friend!"
        }
       
        if unplayedIDs.contains(allHistoricGames[indexPath.row].objectId) {
            cell.backgroundColor = UIColor.init(red: 174/255.0, green: 232/255.0, blue: 181/255.0, alpha: 1.0)
           
            
        }
        print("this is the current id \(currentId) and this is the PFUSer version \(PFUser.currentUser().objectId)")
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("row \(indexPath.row) selected")
        gameVSId = allHistoricGames[indexPath.row].objectId
        if unplayedIDs.contains(allHistoricGames[indexPath.row].objectId) {
            
            let secondViewController = AcceptOrRejectViewController(nibName:"AcceptOrRejectViewController", bundle: nil)
            self.navigationController?.pushViewController(secondViewController, animated: true)
            //self.presentViewController(secondViewController, animated: true, completion: nil)
            
        } else {
            
            let playersQuery = PFQuery(className: "GameVS")
            playersQuery.getObjectInBackgroundWithId(gameVSId) { (object, error) -> Void in
                if let object = object {
                    players = object["allPlayers"] as! [String]
                }
            }
            let secondViewController = ChallengeStatusViewController(nibName:"ChallengeStatusViewController", bundle: nil)
            self.navigationController?.pushViewController(secondViewController, animated: true)
            //self.presentViewController(secondViewController, animated: true, completion: nil)
        }
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
