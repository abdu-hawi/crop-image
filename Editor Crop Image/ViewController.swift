//
//  ViewController.swift
//  Editor Crop Image
//
//  Created by Abdu macOS 15 on 25/11/1441 AH.
//  Copyright © 1441 Abdu macOS 15. All rights reserved.
//

struct Upload:Decodable {
    var status:Int
    var message:String
}

import UIKit

protocol ViewControllerProtocol {
    func setCroppedImage(cropImage:UIImage)
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ViewControllerProtocol {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    let imgPicker = UIImagePickerController()
    
    var imageChoice:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgPicker.delegate = self
    }
    
    func setCroppedImage(cropImage:UIImage){
        mainImage.image = cropImage
        print("end cropped")
    }

    @IBAction func uploadImage(_ sender: Any) {
//        guard let img = (mainImage.image)?.to64Base() else{
//            print("Abdu fetsh cannot convert image")
//            return
//        }
//        connectWithServer(imageString: img)
    }
    
    @IBAction func choiceImage(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (UIAlertAction) in
            self.imgPicker.sourceType = .photoLibrary
            self.present(self.imgPicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
//        mainImage.image = pickedImg
//        dismiss(animated: true, completion: nil)
        
        //MARK: fix orientation
        fixOrientation(img: pickedImg) { (imageFix) in
            self.imageChoice = imageFix
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.performSegue(withIdentifier: "cropSegue", sender: nil)
                })
            }
        }
//        imageChoice = pickedImg
//        dismiss(animated: true, completion: {
//            self.performSegue(withIdentifier: "cropSegue", sender: nil)
//        })
    }
    
    private func fixOrientation(img:UIImage,compltion: @escaping(UIImage)->()){
        DispatchQueue.global(qos: .background).async {
            if (img.imageOrientation == .up){
                compltion(img)
            }
            
            UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
            let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
            img.draw(in: rect)
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            compltion(normalizedImage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cropViewController = segue.destination as? CropViewController{
            cropViewController.initialImage = imageChoice
            cropViewController.delegate = self
            
        }
    }
        
}

extension UIImage{
    func to64Base()->String{
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
