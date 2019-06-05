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

	@IBOutlet weak var adminMessage: UITextView!
	@IBOutlet weak var stdListTable: UITableView!

	var names: String = " hello world"

	var familyInfo : loginResult = loginResult(p1: "", p2: "", names: [], pmsg: "")

//	struct namesArray: Decodable {
//		let id: String
//		let name: String
//	}
//
//	struct loginResult: Decodable {
//		var p1: String
//		var p2: String
//		var names: [namesArray]
//
//		private enum CodingKeys : String, CodingKey {
//			case p1
//			case p2
//			case names
//		}
//	}

	override func viewDidLoad() {
		super.viewDidLoad()
		stdListTable.delegate = self
		stdListTable.dataSource = self

		adminMessage.text = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "") + familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "") + familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")

//		self.navigationController?.navigationBar.topItem?.title = "Dashboard"
//
//		let backButton = UIBarButtonItem()
//		backButton.title = "Back"
//		self.navigationController?.navigationBar.backItem?.title = "back"
//		self.navigationItem.backBarButtonItem = UIBarButtonItem()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return familyInfo.names.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = familyInfo.names[indexPath.row].name
//		cell.detailTextLabel?.text = "1st Grade" + students[0].names[indexPath.row].name

		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToClassList" {
			let destinationController = segue.destination as! ClassListViewController
			destinationController.classTitle = "Quran 7"
			let index = stdListTable.indexPathForSelectedRow?.row
			destinationController.currStudent = familyInfo.names[index!]
		}
	}
}
