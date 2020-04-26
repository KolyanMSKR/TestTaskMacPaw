//
//  InfoCell.swift
//  TestTaskMacPaw
//
//  Created by Admin on 17.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    // MARK: - properties
    
    static let cellID = "InfoCellID"
    
    let nameLabel = UILabel(title: "Description", font: .avenir(size: 16))
    let descriptionLabel = UILabel(title: "Description", font: .avenir(size: 16), numberOfLines: 0)
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
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
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: self.bounds.width * 5/7),
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
}
