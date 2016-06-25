//
//  homeViewController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/20/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
   var loadingMoreView:InfiniteScrollActivityView?
   var isMoreDataLoading = false
   let CellIdentifier = "TableViewCell", HeaderViewIdentifier = "TableViewHeaderView"
    let r:Int = 0
    @IBOutlet weak var pictureScroll: UITableView!
    
    var query = PFQuery(className:"Post")
    var arr: [[PFObject]] = []
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            isMoreDataLoading = true
            let scrollViewContentHeight = pictureScroll.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - pictureScroll.bounds.size.height
            if(scrollView.contentOffset.y > scrollOffsetThreshold && pictureScroll.dragging) {
                isMoreDataLoading = true
                let frame = CGRectMake(0, pictureScroll.contentSize.height, pictureScroll.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadMoreData()
            }
        }
    }
            
    func loadMoreData() {
                
        self.isMoreDataLoading = false
           self.loadingMoreView!.stopAnimating()                                                                      
        self.pictureScroll.reloadData()
       
      
    }
            
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureScroll.dataSource = self
        pictureScroll.delegate = self
        let frame = CGRectMake(0, pictureScroll.contentSize.height, pictureScroll.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        pictureScroll.addSubview(loadingMoreView!)
        
        var insets = pictureScroll.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        pictureScroll.contentInset = insets
        query.includeKey("author")
        query.orderByDescending("createdAt")
        query.limit=20
        pictureScroll.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        pictureScroll.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        let refreshControl = UIRefreshControl()
        refreshControlAction(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
        pictureScroll.insertSubview(refreshControl, atIndex: 0)
        
    }
    
     func refreshControlAction(refreshControl:UIRefreshControl){
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
               
                if let objects = objects {
                    self.arr.removeAll()
                    for object in objects {
                        var arr2:[PFObject] = []
                        arr2.append(object)
                        self.arr.append(arr2)
                        arr2.removeAll()
                    }
                   
                }
            } else {
                print("ERROR")
            }
            refreshControl.endRefreshing()
            self.pictureScroll.reloadData()
            
        }
        
    }
        
        // Do any additional setup after loading the view.
    

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
    
    @IBAction func likeButton(sender: UIButton) {
        let buttonRow = sender.tag
        let post = arr[buttonRow][0]
        post.saveInBackgroundWithBlock(
            { (success: Bool, error: NSError?) -> Void in
            let likes = post["likesCount"] as! Int
            post["likesCount"] = likes + 1
            }
        )
        self.pictureScroll.reloadData()
    }
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arr.count
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = pictureScroll.dequeueReusableCellWithIdentifier("PictureCell", forIndexPath: indexPath) as! PictureCell
        let cellsinSection = arr[indexPath.section]
        let row = indexPath.row
        let p = cellsinSection[row]
        cell.like.tag=row
        cell.like.addTarget(self, action: #selector(homeViewController.likeButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      
        cell.instagramPost = p
      
        
        return cell
    
    }
 
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        
        header.textLabel!.text = arr[section][0]["author"].username
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = pictureScroll.indexPathForCell(sender as! UITableViewCell)
        let r = indexPath!.row
        let CellDetails = segue.destinationViewController as! cellDetailsView
        let post = arr[r]
        CellDetails.username=post[0]["author"].username
        var like:Int = 0
        CellDetails.caption_words=post[0]["caption"] as! String
        if post[0]["likesCount"] == nil{
            like = 0
        } else{
            like = post[0]["likesCount"] as! Int
        }
       
        
        let likes = String(like)
        CellDetails.like_count=likes
        CellDetails.post=post[0]
        
        

    }
 
 
}
