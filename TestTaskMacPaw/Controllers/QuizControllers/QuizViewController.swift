//
//  QuizViewController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 24.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // MARK: - properties
    
    private let breeds = ["abys", "aege", "abob", "acur", "asho", "awir", "amau", "amis", "bali", "bamb",
                          "beng", "birm", "bomb", "bslo", "bsho", "bure", "buri", "cspa", "ctif", "char",
                          "chau", "chee", "csho", "crex", "cymr", "cypr", "drex", "dons", "lihu", "emau",
                          "ebur", "esho", "hbro", "hima", "jbob", "java", "khao", "kora", "kuri", "lape",
                          "mcoo", "mala", "manx", "munc", "nebe", "norw", "ocic", "orie", "pers", "pixi",
                          "raga", "ragd", "rblu", "sava", "sfol", "srex", "siam", "sibe", "sing", "snow",
                          "soma", "sphy", "tonk", "toyg", "tang", "tvan", "ycho"]
    
    private let answers = ["Abyssinian", "Aegean", "American Bobtail", "American Curl", "American Shorthair",
                           "American Wirehair", "Arabian Mau", "Australian Mist", "Balinese", "Bambino", "Bengal",
                           "Birman", "Bombay", "British Longhair", "British Shorthair", "Burmese", "Burmilla",
                           "California Spangled", "Chantilly-Tiffany", "Chartreux", "Chausie", "Cheetoh",
                           "Colorpoint Shorthair", "Cornish Rex", "Cymric", "Cyprus", "Devon Rex", "Donskoy",
                           "Dragon Li", "Egyptian Mau", "European Burmese", "Exotic Shorthair", "Havana Brown",
                           "Himalayan", "Japanese Bobtail", "Javanese", "Khao Manee", "Korat", "Kurilian", "LaPerm",
                           "Maine Coon", "Malayan", "Manx", "Munchkin", "Nebelung", "Norwegian Forest Cat", "Ocicat",
                           "Oriental", "Persian", "Pixie-bob", "Ragamuffin", "Ragdoll", "Russian Blue", "Savannah",
                           "Scottish Fold", "Selkirk Rex", "Siamese", "Siberian", "Singapura", "Snowshoe", "Somali",
                           "Sphynx", "Tonkinese", "Toyger", "Turkish Angora", "Turkish Van", "York Chocolate"]
    
    private let networkService = NetworkService()
    private var proposedAnswers: [String] = []
    private var rightAnswer = ""
    private var totalScore = 0
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total score: 0"
        
        return label
    }()
    
    private let mainContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return container
    }()
    
    private let breedImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asd dsa"
        
        return label
    }()
    
    private let buttonsContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private let falseButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Wrong", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(falseButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private let trueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Right", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(trueButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        generateQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.navigationItem.title = "Quiz"
    }
    
    @objc private func falseButtonAction() {
        if rightAnswer != questionLabel.text {
            scoreIncrease()
        } else {
            scoreDecrement()
        }
        
        generateQuestion()
    }
    
    @objc private func trueButtonAction() {
        if rightAnswer == questionLabel.text {
            scoreIncrease()
        } else {
            scoreDecrement()
        }
        
        generateQuestion()
    }
    
    private func scoreIncrease() {
        totalScore += 2
        scoreLabel.text = "Total score: \(totalScore)"
    }
    
    private func scoreDecrement() {
        totalScore -= 1
        scoreLabel.text = "Total score: \(totalScore)"
    }
    
    private func generateQuestion() {
        if let breedID = breeds.randomElement() {
            guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(breedID)") else {
                return
            }
            
            let request = URLRequest(url: url)
            
            networkService.fetchJSONData(of: Breed.self, request: request) { response in
                if let imageURL = response?.first?.url, let breedName = response?.first?.breeds?.first?.name {
                    self.breedImageView.downloadImage(from: imageURL)
                    
                    self.rightAnswer = breedName
                    self.proposedAnswers = [breedName]
                    if let element = self.answers.randomElement() {
                        self.proposedAnswers.append(element)
                    }
                    
                    self.questionLabel.text = self.proposedAnswers.randomElement()
                }
            }
        }
    }
    
    // MARK: - UI's logic
    
    private func setupUI() {
        view.addSubview(scoreLabel)
        view.addSubview(mainContainerView)
        mainContainerView.addSubview(breedImageView)
        mainContainerView.addSubview(questionLabel)
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(falseButton)
        buttonsContainerView.addSubview(trueButton)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            mainContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainContainerView.heightAnchor.constraint(equalToConstant: view.bounds.height * 3/7)
        ])
        
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 20),
            breedImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 20),
            breedImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -20),
            breedImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 4/7 * 4/7)
        ])
        
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonsContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100),
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            falseButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor),
            falseButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            falseButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor),
            falseButton.trailingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            trueButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor),
            trueButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
            trueButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor),
            trueButton.leadingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: 10)
        ])
    }
    
}
