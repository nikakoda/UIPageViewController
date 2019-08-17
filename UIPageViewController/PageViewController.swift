//
//  PageViewController.swift
//  UIPageViewController
//
//  Created by Ника Перепелкина on 16/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let presentScreenContent = [
        "Первая страница презентации",
        "А это вторая страница презентации",
        "Теперь третья страница презентации",
        "Последняя страница презентации",
        ""
    ]
    
    let emojiArray = ["🧚🏻‍♀️", "🙃", "🤓", "😁", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
         
        if let contentViewController = showViewControllerAtIndex(0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

    func showViewControllerAtIndex(_ index : Int) -> ContentViewController? {
        
        guard index >= 0 else {return nil}
        guard index < presentScreenContent.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "presentationWasViewed")
            dismiss(animated: true, completion: nil)
            return nil}
        
        guard let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else {return nil}
        
        contentViewController.presentText = presentScreenContent[index]
        contentViewController.emoji = emojiArray[index]
        contentViewController.currentPage = index
        contentViewController.numberOfPages = presentScreenContent.count
        
        return contentViewController
    }

}

extension PageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber )
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}
