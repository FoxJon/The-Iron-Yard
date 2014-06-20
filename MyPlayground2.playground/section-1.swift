// Playground - noun: a place where people can play

import UIKit

class MyDataSource : NSObject, UITableViewDataSource {
    
    var dataArray = ["Hello"]
    
        func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
        {
        return dataArray.count
        }
        
        func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
        {
            var cell = UITableViewCell()
            
            cell.text = dataArray[indexPath.row]
            
            cell.backgroundColor = UIColor.redColor()
            
            return cell
            
        }
}

var ds = MyDataSource()

ds.dataArray += "Dinosaur"

var tableView = UITableView(frame:CGRectMake(0, 0, 320, 300), style: .Plain)

tableView.dataSource = ds

tableView.backgroundColor = UIColor.redColor()

tableView.reloadData()

for i in 0..10 {
    
    i % 5 * i
}












