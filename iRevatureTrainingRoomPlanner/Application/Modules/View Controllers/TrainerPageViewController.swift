//
//  TrainerPageViewController.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TrainerPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.dataSource = self
        
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> TrainerSinglePageViewController
    {
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TrainerSinglePageViewController") as! TrainerSinglePageViewController
        
        //This is where the API call should be right now is fed by an array
        //        let trainers = nil//Here we pass the trainer data objects
        // pageContentViewController.trainer = trainers?[index]
        pageContentViewController.trainer = nil
        
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     */
    
    //Before Page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pageContent: TrainerSinglePageViewController = viewController as! TrainerSinglePageViewController
        
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound)) {
            
            //MARK: This needs to be set to our Trainer Collection Count, to be able to return to the last page
            return nil
            
        }
        
        index-=1;
        
        return getViewControllerAtIndex(index: index)
        
    }
    
    //After Page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContent: TrainerSinglePageViewController = viewController as! TrainerSinglePageViewController
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound) {
            return getViewControllerAtIndex(index: 0);
        }
        
        index+=1;
        
        //MARK: This needs to be set to our Trainer Collection Count, to be able to return to the first page
        if (index == 2) {
            
            return getViewControllerAtIndex(index: 0);
            
        }
        
        return getViewControllerAtIndex(index: index)
    }
}
