//
//  BreedCell.swift
//  TestTaskMacPaw
//
//  Created by Admin on 16.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class BreedCell: UITableViewCell {
    
    // MARK: - properties
    
    static let cellID = "BreedCellID"
    private let networkService = NetworkService()
    
    var breed: Breed? {
        didSet {
            nameLabel.text = breed?.name
            
            if let breedID = breed?.id {
                guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(breedID)") else {
                    return
                }
                
                let request = URLRequest(url: url)
                
                networkService.fetchJSONData(of: Breed.self, request: request) { response in
                    if let response = response?.first?.url {
                        self.breedImageView.downloadImage(from: response)
                    }
                }
            }
        }
    }
    
    private let nameLabel = UILabel(font: .avenir(size: 26))
    
    private let breedImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 42
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(breedImageView)
        addSubview(nameLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI's logic
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            breedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            breedImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            breedImageView.widthAnchor.constraint(equalToConstant: 84),
            breedImageView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: breedImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
