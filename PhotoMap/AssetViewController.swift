//
//  AssetViewController.swift
//  PhotoMap
//
//  Created by 平屋真吾 on 2015/05/09.
//  Copyright (c) 2015年 Shingo Hiraya. All rights reserved.
//

import UIKit
import Photos

class AssetViewController: UITableViewController {
    
    var annotation :PhotoAnnotation?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.imageCellSize().height
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let aAnnotation = self.annotation {
            return 2
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            let cellSize = self.imageCellSize()
            
            if let aAnnotation = self.annotation {
                PHImageManager().requestImageForAsset(
                    aAnnotation.asset,
                    targetSize: cellSize,
                    contentMode: .AspectFill,
                    options: nil,
                    resultHandler: {(aImage, info) -> Void in
                        if let image = aImage {
                            cell.assetImage = image
                        }
                    }
                )
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddressCell", forIndexPath: indexPath) as! UITableViewCell
            cell.detailTextLabel?.text = self.annotation?.address
            return cell
        }
    }
    
    // MARK: - private
    
    private func imageCellSize() -> CGSize {
        if let annotation = self.annotation {
            if let asset = annotation.asset {
                let imageRatio = CGFloat(asset.pixelHeight) / CGFloat(asset.pixelWidth)
                let cellWidth = self.tableView.bounds.size.width
                let cellHeight = cellWidth * imageRatio + (1.0 / UIScreen.mainScreen().scale)
                return CGSize(width: cellWidth, height: cellWidth * imageRatio)
            }
        }
        return CGSizeZero
    }
}
