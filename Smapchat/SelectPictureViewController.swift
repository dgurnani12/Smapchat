//
//  SelectPictureViewController.swift
//  Smapchat
//
//  Created by Dinesh  Gurnani on 11/16/17.
//  Copyright © 2017 Dinesh  Gurnani. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker : UIImagePickerController?
    var imageAddedToView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ExistingPicture(_ sender: Any) {
        print("Existing Pictures was tapped")
        if imagePicker != nil {
            imagePicker!.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil )
        }
    }
    
    @IBAction func TakePicture(_ sender: Any) {
        print("Camera was tapped")
        if imagePicker != nil {
            imagePicker!.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil )
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAddedToView = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendTo(_ sender: Any) {
        print("SendTo was tapped")
        
        if imageAddedToView {
            // upload the image
            let imagesFolder = Storage.storage().reference().child("snaps")
            
            if let image = imageView.image {
                let imageData = UIImageJPEGRepresentation(image,0.1)
                
                imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData!, metadata: nil, completion: {(metadata, error) in
                    if let error = error {
                        self.PresentAlert(alert: error.localizedDescription)
                    } else {
                        // Segue to the next view controller
                        if let dlURL = metadata?.downloadURL()?.absoluteString {
                            self.performSegue(withIdentifier: "SendToSegue", sender: dlURL)
                        }
                    }
                })
            }
        } else {
            // Image wasn't properly congifured
            PresentAlert(alert:"An Image is required in order to send a snap")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dlURL = sender as? String {
            if let controller = segue.destination as? RecipientTableViewController {
                controller.downloadURL = dlURL
            }
        }
    }
    
    func PresentAlert(alert:String) {
        let alertController = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
            alertController.dismiss(animated:true, completion: nil)
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
