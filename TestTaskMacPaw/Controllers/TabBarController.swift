//
//  TabBarController.swift
//  TestTaskMacPaw
//
//  Created by Admin on 17.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    private func setTabBar() {
        let breedViewController = BreedViewController()
        breedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        let galleryViewController = GalleryViewController()
        galleryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        viewControllers = [breedViewController, quizViewController, galleryViewController]
    }
    
}
