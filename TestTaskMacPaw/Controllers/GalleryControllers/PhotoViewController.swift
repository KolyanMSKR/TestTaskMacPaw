//
//  PhotoViewController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 22.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private var imageURL: String!
    
    private let breedImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    init(imageURL: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.imageURL = imageURL
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(breedImageView)
        setConstraints()
        
        breedImageView.downloadImage(from: imageURL)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: view.topAnchor),
            breedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
