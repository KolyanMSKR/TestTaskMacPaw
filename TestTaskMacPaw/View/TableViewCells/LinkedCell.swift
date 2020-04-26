//
//  LinkedCell.swift
//  TestTaskMacPaw
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class LinkedCell: UITableViewCell {
    
    static let cellID = "LinkedCellID"
    
    let nameLabel = UILabel(title: "Link", font: .avenir(size: 16))
    
    let linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.text = "link"
        button.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
        
        return button
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(linkButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI's logic
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            linkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            linkButton.widthAnchor.constraint(equalToConstant: self.bounds.width * 5/7),
            linkButton.heightAnchor.constraint(equalToConstant: 30),
            linkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
