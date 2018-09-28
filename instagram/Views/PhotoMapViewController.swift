//
//  PhotoMapViewController.swift
//  instagram
//
//  Created by Andre Campbell on 9/24/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionField: UITextView!
    @IBOutlet weak var selectedPhoto: UIImageView!
    var boolFirstLoad = false
    var vc = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        vc.delegate = self
        vc.allowsEditing = true

      
    }
    override func viewWillAppear(_ animated: Bool) {
        if boolFirstLoad == false {
            openCamera()
            boolFirstLoad = true
        }
    }

    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            self.vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            self.vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // Do something with the images (based on your use case)
        if (editedImage != nil) {
            selectedPhoto.image = editedImage
        }
        else {
            selectedPhoto.image = originalImage
        }
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    @IBAction func openCamera(_ sender: Any) {
        openCamera()
    }
    @IBAction func makePost(_ sender: Any) {
        if (selectedPhoto.image != nil) {
            Post.postUserImage(image: selectedPhoto.image, withCaption: captionField.text, withCompletion: nil)
        _ = navigationController?.popViewController(animated: true)
        print("post success")
        }
        else {
            print("Photo is not set")
        }
    }
    
}
