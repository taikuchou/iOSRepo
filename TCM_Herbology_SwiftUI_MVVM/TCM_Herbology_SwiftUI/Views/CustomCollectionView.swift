//
//  CustomCollectionView.swift
//  TCM_Herbology_SwiftUI_MVVVM
//
//  Created by Tai Kuchou on 2024/1/26.
//

import SwiftUI

struct CustomCollectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let pageViewController = ViewController()
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: ViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomCollectionView
        init(_ pageViewController: CustomCollectionView) {
            self.parent = pageViewController
        }
    }
}



struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        //MARK: - UIPageViewController DataSource
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1]
        }
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1]
        }

        //MARK: - UIPageViewController Delegate
        func pageViewController(_ pageViewController:  UIPageViewController, didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController){
                parent.currentPage = index
            }
        }

    }
}
