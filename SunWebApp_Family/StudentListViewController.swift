//
//  StudentListViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

protocol refreshDataDelegate: class {
	func downloadFamilyInfo()
}

class StudentListViewController: UIViewController,
	UITableViewDelegate, UITableViewDataSource, refreshDataDelegate {

	@IBOutlet weak var stdListTable: UITableView!
	@IBOutlet weak var sNameLabel: UILabel!

	var names: String = " hello world"

	var familyInfo : loginResult = loginResult(p1: "", p2: "", names: [], pmsg: "")

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@objc func recievedNotification() -> Void {
		print("New Communication available")
		let alert = UIAlertController(title: "New Message", message: "A New Message is available, please check it out!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		UIApplication.shared.applicationIconBadgeNumber = 0
	}

	func downloadFamilyInfo() {
		print("DOWNLOAD FAMILY DATA")
		let url = UserDefaults.standard.url(forKey: "loginURL")!

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
			}

			guard let data = data else { return }

			do {
				let decoder = JSONDecoder()
				self.familyInfo = try decoder.decode(loginResult.self, from: data)
				print(self.familyInfo.names[0].name)

				DispatchQueue.main.async {
					self.stdListTable.reloadData()
					self.sNameLabel.text = self.familyInfo.schoolName
				}
			} catch let jsonError {
				print(jsonError)
			}
		}.resume()
	}

	override func loadView() {
		super.loadView()
	}

	let appDelegate = UIApplication.shared.delegate as! AppDelegate

	override func viewDidLoad() {
		super.viewDidLoad()
		stdListTable.delegate = self
		stdListTable.dataSource = self

		downloadFamilyInfo()

		sNameLabel.text = familyInfo.schoolName

		NotificationCenter.default.addObserver(self, selector: #selector(StudentListViewController.recievedNotification), name: NSNotification.Name(rawValue: "recievedNotification"), object: nil)
//		print(appDelegate.didRecieveNotification)
		if appDelegate.didRecieveNotification {
			self.recievedNotification()
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return 100
		default:
			return tableView.rowHeight
		}
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
		if indexPath.section == 0 {
//			cell.textLabel?.text = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")
			cell.textLabel?.text = familyInfo.pmsg.htmlToString
			cell.textLabel?.numberOfLines = 0
			cell.textLabel?.lineBreakMode = .byTruncatingTail
		} else if indexPath.section == 1 {
			cell.textLabel?.text = familyInfo.names[indexPath.row].name
		}

		cell.accessoryType = .disclosureIndicator
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let message = familyInfo.pmsg.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: "")
//			let message = familyInfo.pmsg.htmlToString
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
			let destinationController = segue.destination as! StudentOptionViewController
//			destinationController.classTitle = "Quran 7"
			let index = stdListTable.indexPathForSelectedRow?.row
			destinationController.currStudent = familyInfo.names[index!]
			destinationController.schoolName = familyInfo.schoolName
		}
	}
}
