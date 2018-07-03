//
//  ViewController.swift
//  ClickableImageView
//
//  Created by Prekshya Admin on 7/3/18.
//  Copyright © 2018 Prekshya Admin. All rights reserved.
//

import UIKit

struct SampleItem {
    var imageName = ""
    var imagePoints: [[CGFloat]] = []
    init(imageName: String, imagePoint: [[CGFloat]]) {
        self.imageName = imageName
        self.imagePoints = imagePoint
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var customClickableView: UIView!
    var scrollView: CustomScrollView!
    var sampleItem: SampleItem?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSampleModel()
        setupScrollImageView()
        scrollView.centerImage()
    }
    
    private func configureSampleModel() {
        sampleItem = SampleItem(imageName: SampleModel.names.first!, imagePoint: SampleModel.bodyPartsFront)
        if let sampleItem = sampleItem {
            guard let image = UIImage(named: sampleItem.imageName) else { return }
            self.image = image
        }
    }
    
    func setupScrollImageView() {
        let frame = CGRect(x: 0, y: 0, width: self.customClickableView.frame.width, height: self.customClickableView.frame.height)
        guard let minimumZoom = minimumZoom() else { return }
        scrollView = CustomScrollView(frame, minZoom: minimumZoom, maxZoom: 3.0)
        scrollView.customdelegate = self
        if let sampleItem = sampleItem, let image = image {
            scrollView.getPictureViewWithPoints(points: sampleItem.imagePoints, image: image)
        }
         self.customClickableView.addSubview(scrollView)
    }
    
    func minimumZoom() -> CGFloat? {
        guard let image = image else { return nil }
        return min((self.customClickableView.bounds.size.width)/(image.size.width),(self.customClickableView.bounds.size.height)/(image.size.height))
    }
    
    func paint(view: UIView, color: UIColor = .red) {
        view.backgroundColor = color
    }
}

extension ViewController: CustomScrollViewDelegate {
    func viewSelected(_ selected: Bool, index: Int) {
            let selectedView = scrollView.pictureView.subviews[index+1]
            selected ? paint(view: selectedView) : paint(view: selectedView, color: .clear)
    }
}

