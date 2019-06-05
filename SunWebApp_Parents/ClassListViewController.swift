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

	var classTitle: String = "Arabic 1"

	var currStudent: student = student.init(id: "0", name: "")

	@IBOutlet weak var classListTableView: UITableView!

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
//	@IBAction func unwindToStudentList(_ unwindSegue: UIStoryboardSegue) {
//		let sourceViewController = unwindSegue.source
//		let destinationViewController = StudentListViewController
//		// Use data from the view controller which initiated the unwind segue
//		self.unwind(for: <#T##UIStoryboardSegue#>, towards: <#T##UIViewController#>)
//	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		cell.textLabel?.text = classTitle

		return cell
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		classListTableView.delegate = self
		classListTableView.dataSource = self

		navigationItem.title = currStudent.name
	}
}
