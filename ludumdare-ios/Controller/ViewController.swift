//
//  ViewController.swift
//  LudumDare
//
//  Created by Brody Eller on 5/2/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var feed = Feed()
  var selectedNode: Node?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    feed.getNodes(offset: 0, limit: 10) {
      self.tableView.reloadData()
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
    //return 250
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedNode = feed.node(at: indexPath.row)
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "detailSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue" {
      let destinationVC = segue.destination as! DetailViewController
      destinationVC.node = selectedNode
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feed.nodeCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let nodeCell = tableView.dequeueReusableCell(withIdentifier: "nodeCell", for: indexPath) as! NodeTableViewCell
    if let node = feed.node(at: indexPath.row) {
//      nodeCell.nodeView.titleLabel.text = node.name
//      nodeCell.nodeView.authorLabel.text = node.author.description
      nodeCell.nodeView.node = node
    } else {
      nodeCell.nodeView.titleLabel.text = "Loading..."
      nodeCell.nodeView.authorLabel.text = ""
      nodeCell.nodeView.bodyTextView.attributedText = NSAttributedString(string: "")
    }
    
    return nodeCell
  }
}

