//
//  StudentListViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController,
	UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var stdListTable: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		stdListTable.delegate = self
		stdListTable.dataSource = self
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = "Usmaan Jaffer"
		cell.detailTextLabel?.text = "1st Grade"

		return cell
	}
}
