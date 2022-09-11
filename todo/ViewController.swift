//
//  ViewController.swift
//  todo
//
//  Created by K I on 2022/09/08.
//

import UIKit
import SwiftUI

class ViewController: UIViewController , UITableViewDataSource {
    
    @IBOutlet var table:UITableView!
    
    static var titleArray:[[String:String]]=[[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource=self
        ViewController.titleArray=[
            ["title": "TestTodo", "detail": "2023/9/5"]
        ]
        print(ViewController.titleArray.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        table.reloadData()
      }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return ViewController.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text=ViewController.titleArray[indexPath.row]["title"]
        cell?.detailTextLabel?.text=ViewController.titleArray[indexPath.row]["detail"]
        
        return cell!
    }
    
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue) {
        self.table.reloadData()
        print(ViewController.titleArray.count)
    }
  


}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ViewController.titleArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
