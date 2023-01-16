//
//  ViewController.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
//    private var viewModel = CommentDetailViewModel()
    private var viewModel = StaffViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    private func updateUI(){
//        nameLabel.text = viewModel.comment.name
//        bodyLabel.text = viewModel.comment.body
//        emailLabel.text = viewModel.comment.email
    }
    
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
//        self.navigationController?.pushViewController(vc, animated: true)
      
    }

}

