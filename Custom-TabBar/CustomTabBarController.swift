//
//  ViewController.swift
//  Custom-TabBar
//
//  Created by ADMIN on 30/03/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

struct TabItem {
    let item: UIButton
    let itemTitle: String
    let defaultImage: UIImage
    let selectedImage: UIImage
    let viewController: UIViewController
    
}

class CustomTabBarController: UIViewController {
    @IBOutlet var customTabBarView: UIView!
    @IBOutlet weak var contentView: UIView!
    

    @IBOutlet var homeButton: UIButton!
    @IBOutlet var cloudButton: UIButton!
    @IBOutlet var folderButton: UIButton!
    @IBOutlet var trayButton: UIButton!
    @IBOutlet var messageButton: UIButton!
    
    let selectedIndex = 0
    

    var tabItems: [TabItem]!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()

        homeButton.addTarget(self, action: #selector(didTapHomeButton(_:)), for: .touchUpInside)
        cloudButton.addTarget(self, action: #selector(didTapCloudButton(_:)), for: .touchUpInside)
        folderButton.addTarget(self, action: #selector(didTapFolderButton(_:)), for: .touchUpInside)
        trayButton.addTarget(self, action: #selector(didTapTrayButton(_:)), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(didTapMessageButton(_:)), for: .touchUpInside)
        
        guard let homeVC = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        guard let cloudVC = storyboard?.instantiateViewController(identifier: "CloudViewController") as? CloudViewController else { return }
        guard let folderVC = storyboard?.instantiateViewController(identifier: "FolderViewController") as? FolderViewController else { return }
        guard let trayVC = storyboard?.instantiateViewController(identifier: "TrayViewController") as? TrayViewController else { return }
        guard let paperPlaneVC = storyboard?.instantiateViewController(identifier: "PaperPlaneViewController") as? PaperPlaneViewController else { return }
        
        tabItems = [
            TabItem(item: homeButton, itemTitle: "Home", defaultImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, viewController: homeVC),
            TabItem(item: cloudButton, itemTitle: "Home", defaultImage: UIImage(systemName: "cloud")!, selectedImage: UIImage(systemName: "cloud.fill")!, viewController: cloudVC),
            TabItem(item: folderButton, itemTitle: "Home", defaultImage: UIImage(systemName: "folder")!, selectedImage: UIImage(systemName: "folder.fill")!, viewController: folderVC),
            TabItem(item: trayButton, itemTitle: "Home", defaultImage: UIImage(systemName: "tray")!, selectedImage: UIImage(systemName: "tray.fill")!, viewController: trayVC),
            TabItem(item: messageButton, itemTitle: "Home", defaultImage: UIImage(systemName: "paperplane")!, selectedImage: UIImage(systemName: "paperplane.fill")!, viewController: paperPlaneVC),
        ]

        DispatchQueue.main.async {[weak self] in
            self?.selectedTabItem(is: self!.tabItems[self!.selectedIndex].item)
        }
    }

    @objc func didTapHomeButton(_ sender: UIButton) {
        selectedTabItem(is: sender)
    }

    @objc func didTapCloudButton(_ sender: UIButton) {
        selectedTabItem(is: sender)
    }

    @objc func didTapFolderButton(_ sender: UIButton) {
        selectedTabItem(is: sender)
    }

    @objc func didTapTrayButton(_ sender: UIButton) {
        selectedTabItem(is: sender)
    }

    @objc func didTapMessageButton(_ sender: UIButton) {
        selectedTabItem(is: sender)
    }

    private func selectedTabItem(is button: UIButton) {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.tabItems.forEach {
                               if $0.item == button {
                                   $0.item.setImage($0.selectedImage, for: .normal)
                                   $0.item.transform = .init(scaleX: 1.5, y: 1.5)
                                self?.contentView.addSubview($0.viewController.view)
                                $0.viewController.didMove(toParent: self)
                               } else {
                                   $0.item.setImage($0.defaultImage, for: .normal)
                                   $0.item.transform = .init(scaleX: 1, y: 1)
                               }
                           }

                        self?.view.layoutIfNeeded()

        })
    }

    private func configureTabBar() {
        customTabBarView.layer.cornerRadius = customTabBarView.frame.height / 2
        customTabBarView.layer.masksToBounds = false
        customTabBarView.clipsToBounds = false

        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
    }
}
