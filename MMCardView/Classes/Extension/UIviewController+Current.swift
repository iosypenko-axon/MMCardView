//
//  UIViewControllerExtension.swift
//  Pods
//
//  Created by MILLMAN on 2016/9/21.
//
//

import UIKit

extension UIViewController {
    
    fileprivate static func findBestViewController(_ vc: UIViewController) -> UIViewController? {
        if (vc.presentedViewController) != nil {
            return UIViewController.findBestViewController(vc.presentedViewController ?? vc)
        } else if vc.isKind(of: UISplitViewController.classForCoder()) {
            guard let splite = vc as? UISplitViewController else { return vc }
            if !splite.viewControllers.isEmpty {
                return UIViewController.findBestViewController(splite.viewControllers.last ?? vc)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.classForCoder()) {
            guard let svc = vc as? UINavigationController else { return vc }
            if !svc.viewControllers.isEmpty {
                return UIViewController.findBestViewController(svc.topViewController ?? vc)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.classForCoder()) {
            if let svc = vc as? UITabBarController, let v = svc.viewControllers, !v.isEmpty {
                return UIViewController.findBestViewController(svc.selectedViewController ?? vc)

            } else {
                return vc
            }
        } else {
            return vc
        }
    }
    
    static func currentViewController() -> UIViewController? {
        guard let vc: UIViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        return UIViewController.findBestViewController(vc)
    }
}
