//
//  NodeView.swift
//  LudumDare
//
//  Created by Brody Eller on 5/3/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//

import UIKit
import Down

@IBDesignable
class NodeView: UIStackView, NibLoadable {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var bodyStackView: UIStackView!
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupFromNib()
  }
  
  public required init(coder: NSCoder) {
    super.init(coder: coder)
    setupFromNib()
  }
  
}

