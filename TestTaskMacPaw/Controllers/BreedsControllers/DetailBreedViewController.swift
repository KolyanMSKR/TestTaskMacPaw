//
//  DetailBreedViewController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 16.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

// MARK: - CellModel

extension DetailBreedViewController {
    fileprivate enum CellModel {
        case description
        case linked
    }
}

class DetailBreedViewController: UIViewController {
    
    // MARK: - UI's elements
    
    private let breedImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12 
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let nameLabel = UILabel(title: "Name:", font: .avenir(size: 14))
    
    // MARK: - properties
    
    private let networkService = NetworkService()
    private let breed: Breed
    private let tableView = UITableView()
    private var models: [CellModel] = [.linked, .description]
    
    // MARK: - Inits
    
    init(breed: Breed) {
        self.breed = breed
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    	
    // MARK: - Lifecycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = breed.name
        
        view.addSubview(breedImageView)
        
        setupTableView()
        setConstraints()
        setupImage()
    }
    
    private func setupImage() {
        if let breedID = breed.id {
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
    
    // MARK: - UI's logic
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.cellID)
        tableView.register(LinkedCell.self, forCellReuseIdentifier: LinkedCell.cellID)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            breedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            breedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            breedImageView.heightAnchor.constraint(equalToConstant: 200),
            breedImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: breedImageView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension DetailBreedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model {
        case .description:
            if let description = breed.description {
                let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.cellID, for: indexPath) as! InfoCell
                
                cell.descriptionLabel.text = description
                
                return cell
            }
        case .linked:
            if let wikiUrl = breed.wikipediaURL {
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkedCell.cellID,
                                                         for: indexPath) as! LinkedCell
                
                cell.nameLabel.text = "Wikipedia:"
                cell.linkButton.setTitle(wikiUrl, for: .normal)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - UITableViewDelegate

extension DetailBreedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        switch model {
        case .description:
            let height = (breed.description?.height(width: view.bounds.width*5/7 - 28, font: .avenir(size: 16)!))! + 40
            return height
        case .linked:
            return 50
        }
    }
    
}
