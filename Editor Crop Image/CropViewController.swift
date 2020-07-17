//
//  CropViewController.swift
//  Editor Crop Image
//
//  Created by Abdu macOS 15 on 25/11/1441 AH.
//  Copyright © 1441 Abdu macOS 15. All rights reserved.
//

import UIKit

class CropViewController: UIViewController , UIScrollViewDelegate{

    @IBOutlet weak var cropImg: UIImageView!
    @IBOutlet weak var grideImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var initialImage:UIImage?
    var delegate:ViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view.
        guard let initImg = initialImage else {
            return
        }
        cropImg.image = initImg
        self.scrollView.decelerationRate = .fast
        setupInitialZoomScale()
    }
    
    var croppedImage:UIImage?
    @IBAction func agreeBtn(_ sender: Any) {
        dismiss(animated: true) {
            let gridToImage = self.grideImg.convert(self.grideImg.bounds, to: self.cropImg)
            let croppedCGImage = self.cropImg.image?.cgImage?.cropping(to: gridToImage)
            self.delegate?.setCroppedImage(cropImage: UIImage(cgImage: croppedCGImage!))
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropImg
    }
    
    private func setupInitialZoomScale() {
        let scrollSize = self.scrollView.bounds.size
        if let imagesize = self.cropImg.image?.size {
            let widthRatio = scrollSize.width / imagesize.width
            let heightRatio = scrollSize.height / imagesize.height
            let minZoom = max(widthRatio, heightRatio)
            scrollView.minimumZoomScale = minZoom
            scrollView.zoomScale = minZoom
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerScrollViewContents()
    }

    private func centerScrollViewContents() {
        let frameHeight = cropImg.frame.size.height
        let frameWidth = cropImg.frame.size.width
        var point = CGPoint()
        if frameHeight < frameWidth {
            point.x = (frameWidth - scrollView.bounds.width)/2
        } else {
            point.y = (frameHeight - scrollView.bounds.height)/2
        }
        scrollView.setContentOffset(point, animated: false)
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
}
