//
//  ClassListViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class ClassListViewController: UIViewController,
	UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var classListTableView: UITableView!

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		cell.textLabel?.text = "Arabic 1"

		return cell
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		classListTableView.delegate = self
		classListTableView.dataSource = self
	}
}
