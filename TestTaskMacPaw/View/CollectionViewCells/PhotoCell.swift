//
//  PhotoCell.swift
//  TestTaskMacPaw
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static var cellID = "PhotoCellID"	
    
    var imageStringURL: String? {
        didSet {
            if let stringURL = imageStringURL {
                breedImageView.downloadImage(from: stringURL)
            }
        }
    }
    
    let breedImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(breedImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            breedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            breedImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            breedImageView.topAnchor.constraint(equalTo: self.topAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
