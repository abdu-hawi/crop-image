//
//  ShowImageViewController.swift
//  Editor Crop Image
//
//  Created by Abdu macOS 15 on 26/11/1441 AH.
//  Copyright © 1441 Abdu macOS 15. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    
    @IBOutlet weak var imgView:UIImageView!
    
    var initImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = initImage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
