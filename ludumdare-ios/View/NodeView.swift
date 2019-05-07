//
//  NodeView.swift
//  LudumDare
//
//  Created by Brody Eller on 5/3/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//

import UIKit

@IBDesignable
class NodeView: UIStackView, NibLoadable {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var bodyTextView: UITextView!
  
  var node: Node! {
    didSet {
      titleLabel.text = node.name
      authorLabel.text = node.author.description
      bodyTextView.attributedText = node.body
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupFromNib()
  }
  
  public required init(coder: NSCoder) {
    super.init(coder: coder)
    setupFromNib()
  }
  
}

