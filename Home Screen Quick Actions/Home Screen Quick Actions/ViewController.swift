//
//  ViewController.swift
//  Home Screen Quick Actions
//
//  Created by 马卿 on 16/9/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    var tableView : UITableView?
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds)
        tableView?.registerClass(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        tableView?.delegate = self
        //Check for force touch feature, and add force touch/previewing capability.
        if traitCollection.forceTouchCapability == .Available{
            /*
             Register for `UIViewControllerPreviewingDelegate` to enable
             "Peek" and "Pop".
             (see: MasterViewController+UIViewControllerPreviewing.swift)
             
             The view controller will be automatically unregistered when it is
             deallocated.
             */
            
            registerForPreviewingWithDelegate(self, sourceView: tableView!)
        } else {
            // Create an alert to display to the user.
          
        }
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
extension ViewController : UIViewControllerPreviewingDelegate{
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
    }
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return UIViewController()
    }
}
