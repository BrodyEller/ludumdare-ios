//
//  DetailViewController.swift
//  LudumDare
//
//  Created by Brody Eller on 5/2/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  var node: Node!
  
  @IBOutlet weak var nodeView: NodeView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nodeView.titleLabel.text = node.name
    nodeView.authorLabel.text = node.author.description
    nodeView.bodyTextView.attributedText = node.body
  }
}
