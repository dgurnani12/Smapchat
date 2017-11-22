//
//  DetailedSnapViewController.swift
//  Smapchat
//
//  Created by Dinesh  Gurnani on 11/21/17.
//  Copyright © 2017 Dinesh  Gurnani. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class DetailedSnapViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var LabelView: UILabel!
    
    var snap : DataSnapshot?
    var targetImageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let snapDic = snap?.value as? NSDictionary {
            if let message = snapDic["description"] as? String {
                if let imageURI = snapDic["imageURI"] as? String {
                    if let imageName = snapDic["imageFileName"] as? String {
                        
                        self.LabelView.text = message
                        
                        let block: SDExternalCompletionBlock! = {(image, error, cacheType, imageURL) -> Void in
                            self.LabelView.text = message
                        }
                        
                        self.ImageView.sd_setImage(with: URL(string: imageURI), completed: block)
                        
                        //self.ImageView.sd_setImage(with: URL(string: imageURI))
                        //self.LabelView.text = message
                        self.targetImageName = imageName
                    
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let targetUid = Auth.auth().currentUser?.uid {
            if let key = self.snap?.key {
                Database.database().reference().child("users").child(targetUid).child("snaps").child(key).removeValue()
            }
            Storage.storage().reference().child("snaps").child(self.targetImageName).delete(completion: nil)
        }
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
