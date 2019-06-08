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

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		stdListTable.delegate = self
		stdListTable.dataSource = self

		adminMessage.text = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "") // + familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "") + familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")


	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 1
		case 1:
			return familyInfo.names.count
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		if indexPath.section == 1 {
			cell.textLabel?.text = familyInfo.names[indexPath.row].name
		} else if indexPath.section == 0 {
			cell.textLabel?.text = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")
		}

		cell.accessoryType = .disclosureIndicator
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let message = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")
			let alert = UIAlertController(title: "Admin Message", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		} else if indexPath.section == 1 {
			OperationQueue.main.addOperation {
				self.performSegue(withIdentifier: "goToClassList", sender: nil)
			}
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Admin Message"
		case 1:
			return "My Kids"
		default:
			return "Admin Message"
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToClassList" {
			let destinationController = segue.destination as! ClassListViewController
//			destinationController.classTitle = "Quran 7"
			let index = stdListTable.indexPathForSelectedRow?.row
			destinationController.currStudent = familyInfo.names[index!]
		}
	}
}
