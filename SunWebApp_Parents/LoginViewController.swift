//
//  LoginViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var schoolCodeTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	@IBAction func loginButtonClicked(_ sender: Any) {
		OperationQueue.main.addOperation {
			self.performSegue(withIdentifier: "goToStdList", sender: nil)
		}
	}
}
