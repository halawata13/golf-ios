import Foundation
import UIKit

class TutorialPageViewController: UIPageViewController {

    var pageViewControllers: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 140 / 255, green: 0, blue: 0, alpha: 1)

        pageViewControllers = [
            "Tutorial1ViewController",
            "Tutorial2ViewController",
            "Tutorial3ViewController",
        ]

        setViewControllers([storyboard!.instantiateViewController(withIdentifier: pageViewControllers[0])], direction: .forward, animated: true)
        dataSource = self
    }

    func getViewController(pageNum: Int) -> UIViewController {
        return storyboard!.instantiateViewController(withIdentifier: pageViewControllers[pageNum])
    }

    func end() {
        UserDefaults.standard.set(true, forKey: "initial")
        dismiss(animated: true)
    }
}

extension TutorialPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: Tutorial3ViewController.self) {
            return getViewController(pageNum: 1)
        } else if viewController.isKind(of: Tutorial2ViewController.self) {
            return getViewController(pageNum: 0)
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: Tutorial1ViewController.self) {
            return getViewController(pageNum: 1)
        } else if viewController.isKind(of: Tutorial2ViewController.self) {
            return getViewController(pageNum: 2)
        } else {
            return nil
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
