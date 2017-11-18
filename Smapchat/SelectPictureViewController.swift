//
//  SelectPictureViewController.swift
//  Smapchat
//
//  Created by Dinesh  Gurnani on 11/16/17.
//  Copyright © 2017 Dinesh  Gurnani. All rights reserved.
//

import UIKit

class SelectPictureViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ExistingPicture(_ sender: Any) {
    }
    
    @IBAction func TakePicture(_ sender: Any) {
    }
    
    @IBAction func SendTo(_ sender: Any) {
    }
    
    @IBAction func MessageText(_ sender: Any) {
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
