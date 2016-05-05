//
//  MainViewController.swift
//  Gael Events
//
//  Created by Ayalew Lidete on 5/4/16.
//  Copyright © 2016 GaelTech. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UITableViewController {
    
    var posts: [String: String] = [String: String]()
    
    
    var ref = Firebase(url:"https://smcevents.firebaseio.com/")
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        var keys: Array = Array(self.posts.keys)
        cell.textLabel?.text = posts[keys[indexPath.row]] as String!
        print("Index Path \(indexPath.row)")
        
        return cell

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            let snapshotPosts = snapshot.value.objectForKey("posts")
            
            if let snapshotPosts = snapshotPosts {
                self.posts = snapshotPosts as! [String: String]
            } else {
                self.posts = [:]
            }

            print(self.posts)
            self.tableView.reloadData()

        })
    }

    @IBAction func logout(sender: AnyObject) {
        
        ref.unauth()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if((sender!.isKindOfClass(UITableViewCell))) {
            let row = (self.tableView.indexPathForSelectedRow?.row)!
            let eventPage = segue.destinationViewController as? EventInfoPage
            
            var keys: Array = Array(self.posts.keys)
            //        var data = posts[keys[row]]
            
            print(posts)
            eventPage?.whatVar = posts[keys[row]]!
            eventPage?.whenVar = "05/11/2016"
            eventPage?.whereVar = "Saint Mary's College of CA"
            eventPage?.whoVar = "All Students!"
            eventPage?.descriptionVar = "Here is where you can type out the description of your event. You can include the date, location, and a brief description. So much fun!"
}

    }

}
