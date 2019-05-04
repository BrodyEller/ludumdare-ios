//
//  NibLoadable.swift
//  LudumDare
//
//  Created by Brody Eller on 5/3/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//
import UIKit

protocol NibLoadable {
  static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
  static var nibName: String {
    return String(describing: Self.self)
  }
  
  static var nib: UINib {
    return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
  }
  
  func setupFromNib() {
    guard let nodeView = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
      fatalError("Error loading \(self) from nib")
    }
    addSubview(nodeView)
    nodeView.translatesAutoresizingMaskIntoConstraints = false
    nodeView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
    nodeView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    nodeView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    nodeView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
  }
}
