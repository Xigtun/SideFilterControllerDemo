//
//  FilterController.swift
//  SideFilterControllerDemo
//
//  Created by cysu on 24/10/2016.
//  Copyright © 2016 cysu. All rights reserved.
//

import UIKit

class FilterController: UITableViewController {

    lazy var leftFilterView: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: leftViewWidth, height: screenHeight)
        tempView.isUserInteractionEnabled = true
        tempView.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(leftItemAction(_:)))
        tempView.addGestureRecognizer(tap)
        return tempView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FilterController"

        let leftItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(leftItemAction(_:)))
        self.navigationItem.leftBarButtonItem = leftItem

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        UIApplication.shared.keyWindow?.addSubview(leftFilterView)
    }

    func leftItemAction(_ sender: Any) {
        leftFilterView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let controller = UIViewController()
        controller.title = "Sub Controller"
        controller.view.backgroundColor = UIColor.lightGray
        self.navigationController?.pushViewController(controller, animated: true)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")! as UITableViewCell
        cell.textLabel?.text = String(indexPath.row)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
