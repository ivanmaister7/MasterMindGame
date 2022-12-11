//
//  ItemCell.swift
//  MasterMindGame
//
//  Created by Master on 09.12.2022.
//

import UIKit

class ItemCell: UICollectionViewCell {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
//        NSLayoutConstraint.activate([
//            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 100.0)
//        ])
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label(20)]|", options: [], metrics: nil, views: ["label":label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label(20)]|", options: [], metrics: nil, views: ["label":label]))
    }
}
