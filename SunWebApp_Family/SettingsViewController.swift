//
//  SettingsViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 7/11/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!


	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Settings"

		let parentName = UserDefaults.standard.string(forKey: "name") ?? ""

		nameLabel.text = "Welcome \(parentName)!"
	}

	@IBAction func logoutButton() {

		UserDefaults.standard.removeObject(forKey: "name")
		UserDefaults.standard.removeObject(forKey: "schoolCode")
		UserDefaults.standard.removeObject(forKey: "loginURL")
		UserDefaults.standard.set(false, forKey: "didLogin")

		performSegue(withIdentifier: "logoutSegue", sender: nil)
	}

}
