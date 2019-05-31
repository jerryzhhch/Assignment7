//
//  DetailViewController.swift
//  LockBox
//
//  Created by Jerry Zhou on 5/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        setupView()
    }
    
    func setupView() {
        let content = viewModel.currentContent
        switch content.isVideo {
        case true:
            guard let url = FileService.loadWithFM(content.path!), let image = url.thumbnailForVideo() else {
                return
            }
            self.imageView.image = image
        case false:
            guard let url = FileService.loadWithFM(content.path!), let image = UIImage(contentsOfFile: url.path) else {
                return
            }
            self.imageView.image = image
        }
    }
    
    func setupScroll() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.backgroundColor = .black
    }
    
    
} //end class

extension ContentViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
