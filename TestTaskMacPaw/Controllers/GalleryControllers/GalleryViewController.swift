//
//  GalleryViewController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    // MARK: - properties
    
    private let networkService = NetworkService()
    private var collectionView: UICollectionView!
    
    private var images: [Image] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        getJSONData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.navigationItem.title = "Gallery"
    }
    
    private func getJSONData() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=100") else { return }
        let request = URLRequest(url: url)
        
        networkService.fetchJSONData(of: Image.self, request: request) { (response) in
            guard let response = response else {
                self.showAlert(title: "Error", message: "Data is not available!")
                return
            }
            
            for image in response {
                self.images.append(image)
            }
        }
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellID)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellID, for: indexPath) as! PhotoCell
        
        cell.backgroundColor = .red
        
        cell.imageStringURL = images[indexPath.item].url
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoViewController = PhotoViewController(imageURL: images[indexPath.item].url)
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 3
        let itemBorder = collectionView.bounds.width / CGFloat(columns)
        
        return CGSize(width: itemBorder, height: itemBorder)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
