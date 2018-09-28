//
//  ViewController.swift
//  instagram
//
//  Created by Andre Campbell on 9/18/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import PKHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    

    var instaPosts: [Post] = []
    var selectedCell: Int!
    var refreshControl: UIRefreshControl!
    let alertController = UIAlertController(title: "Can not get Posts", message: "The internet connection appeas to be offline.", preferredStyle: .alert)
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func didLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view, typically from a nib.
        getPosts()
        // create a cancel action
        let retryAction = UIAlertAction(title: "retry", style: .default) { (action) in
            self.didPullToRefresh(self.refreshControl)
        }
        // add the cancel action to the alertController
        alertController.addAction(retryAction)
        

    }
    
    @IBAction func didTapImage(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        self.selectedCell = sender.view!.tag
        performSegue(withIdentifier:"ShowDetails", sender: self)
        // User tapped at the point above. Do something with that if you want.
        
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        HUD.show(.progress)
        // Now some long running task starts...
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // ...and once it finishes we flash the HUD for a second.
            self.getPosts()
            HUD.flash(.success, delay: 1.0)
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Table View Required Functions
    //
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.instaPosts.count != 0 {
            return self.instaPosts.count
        }
        else {
            print("No Post Found")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramPostCell", for: indexPath) as! InstagramPostCell
        let post = self.instaPosts[indexPath.row]
        cell.instagramPost = post
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage(sender:)))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        cell.mediaView.tag = indexPath.row
        cell.mediaView.isUserInteractionEnabled = true
        cell.mediaView.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    func getPosts(){
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.includeKey("createdAt")
        query.limit = 20
        query.findObjectsInBackground(block:{ (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts{
                self.instaPosts = posts as! [Post]
            }
            else{
                print(error!.localizedDescription)
            }
                 self.tableView.reloadData()
        })
        self.refreshControl.endRefreshing()
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(segue.identifier)
        if segue.destination is DetailPostViewController
        {
            let vc = segue.destination as! DetailPostViewController
            let post = instaPosts[self.selectedCell]
            print(post)
            if post.caption != "" {
                print(post.caption)
                vc.caption = post.caption
            }
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: post.createdAt!) // string purpose I add here
            print(myString)
            vc.timestamp = myString

            
           // vc?.username = "Arthur Dent"
        }
    }
    
    
}

