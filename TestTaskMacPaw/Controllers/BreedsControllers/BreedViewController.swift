//
//  ViewController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 16.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class BreedViewController: UIViewController {
    
    // MARK: - properties
    
    private let tableView = UITableView()
    private let networkService = NetworkService()
    
    private var breeds: [Breed] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setConstraints()
        getJSONData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.navigationItem.title = "Breeds"
    }
    
    private func getJSONData() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return }
        
        let request = URLRequest(url: url)
        
        networkService.fetchJSONData(of: Breed.self, request: request) { response in
            guard let response = response else {
                self.showAlert(title: "Error", message: "Data is not available!")
                
                return
            }
            
            for breed in response {
                self.breeds.append(breed)
            }
        }
    }
    
    // MARK: - UI's logic
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.cellID)
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension BreedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.cellID, for: indexPath) as! BreedCell
        cell.breed = breeds[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension BreedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailBreedVC = DetailBreedViewController(breed: breeds[indexPath.row])
        navigationController?.pushViewController(detailBreedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
