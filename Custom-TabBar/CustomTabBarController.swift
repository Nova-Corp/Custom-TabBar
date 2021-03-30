//
//  ViewController.swift
//  Custom-TabBar
//
//  Created by ADMIN on 30/03/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

struct TabItem {
    let itemTitle: String
    let defaultImage: UIImage
    let selectedImage: UIImage
    let viewController: UIViewController
}

class CustomTabBarController: UIViewController {
    @IBOutlet var customTabBarView: UIView!
    @IBOutlet var contentView: UIView!

    let selectedIndex = 0

    var tabItems: [TabItem]!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let homeVC = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        guard let cloudVC = storyboard?.instantiateViewController(identifier: "CloudViewController") as? CloudViewController else { return }
        guard let folderVC = storyboard?.instantiateViewController(identifier: "FolderViewController") as? FolderViewController else { return }
        guard let trayVC = storyboard?.instantiateViewController(identifier: "TrayViewController") as? TrayViewController else { return }
        guard let paperPlaneVC = storyboard?.instantiateViewController(identifier: "PaperPlaneViewController") as? PaperPlaneViewController else { return }

        tabItems = [
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, viewController: homeVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "cloud")!, selectedImage: UIImage(systemName: "cloud.fill")!, viewController: cloudVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "folder")!, selectedImage: UIImage(systemName: "folder.fill")!, viewController: folderVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "tray")!, selectedImage: UIImage(systemName: "tray.fill")!, viewController: trayVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "paperplane")!, selectedImage: UIImage(systemName: "paperplane.fill")!, viewController: paperPlaneVC),
        ]
        configureTabBar()
    }

    @IBAction func didTapTabBarItem(_ sender: UIButton) {
        selectedTabItem(is: sender.tag)
    }

    private func selectedTabItem(is index: Int) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in

                           for i in 1 ... self!.tabItems.count {
                               let tabItem = self?.view.viewWithTag(i) as? UIButton

                               if index == i {
                                   tabItem?.setImage(self!.tabItems[i - 1].selectedImage, for: .normal)
                                   tabItem?.transform = .init(scaleX: 1.5, y: 1.5)
                               } else {
                                   tabItem?.setImage(self!.tabItems[i - 1].defaultImage, for: .normal)
                                   tabItem?.transform = .init(scaleX: 1, y: 1)
                               }
                           }

                           self?.view.layoutIfNeeded()

        })

        contentView.addSubview(tabItems[index - 1].viewController.view)
        tabItems[index - 1].viewController.didMove(toParent: self)
    }

    private func configureTabBar() {
        customTabBarView.layer.cornerRadius = customTabBarView.frame.height / 2
        customTabBarView.layer.masksToBounds = false
        customTabBarView.clipsToBounds = false

        DispatchQueue.main.async { [weak self] in
            self?.selectedTabItem(is: self!.selectedIndex + 1)
        }
    }
}
