//
//  MessageListViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 7/3/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {

	var currStudent: student = student.init(id: "0", name: "")

	var messageList: [message] = []

	var messageIdx: Int = 0

	var classes: classList = classList(gradingScale: [], assignmentList: [], courseGrades: [])

	var schoolName: String = ""

	@IBOutlet weak var messageListTableView: UITableView!
	@IBOutlet weak var sNameLabel: UILabel!

	func sortClassesByCcode(this: courseGrade, that:courseGrade) -> Bool {
		return this.courseCode < that.courseCode
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		messageListTableView.dataSource = self
		messageListTableView.delegate = self

		classes.courseGrades = classes.courseGrades.sorted(by: sortClassesByCcode)

		sNameLabel.text = schoolName
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return classes.courseGrades.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var numMessages = 0
		for message in messageList {
			if message.Ccode == classes.courseGrades[section].courseCode {
				numMessages += 1
			}
		}
		return numMessages
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return classes.courseGrades[section].courseName
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

		var idx = 0

		for (i, message) in messageList.enumerated() {
			if message.Ccode == classes.courseGrades[indexPath.section].courseCode {
				idx = i + indexPath.row
				break
			}
		}

		cell.textLabel?.text = messageList[idx].subject + " __ " + messageList[idx].Ccode  // classes.courseGrades[indexPath.section].courseCode
		cell.detailTextLabel?.text = messageList[idx].timestamp

		cell.accessoryType = .disclosureIndicator
		cell.selectionStyle = .none

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		var idx = 0

		for (i, message) in messageList.enumerated() {
			if message.Ccode == classes.courseGrades[indexPath.section].courseCode {
				idx = i + indexPath.row
				break
			}
		}

		messageIdx = idx

		print(messageList[idx].message)

//		messageListTableView.cellForRow(at: indexPath)?.textLabel?.text = messageList[idx].message.htmlToString
		OperationQueue.main.addOperation {
			self.performSegue(withIdentifier: "goToMessageDetail", sender: nil)
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToMessageDetail" {
			let destinationViewController = segue.destination as! MessageDetailViewController
			destinationViewController.currMessage = messageList[messageIdx]
			destinationViewController.schoolName = self.schoolName
		}
	}
}

extension String {
	var htmlToAttributedString: NSAttributedString? {
		guard let data = data(using: .utf8) else { return NSAttributedString() }
		do {
			return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			return NSAttributedString()
		}
	}
	var htmlToString: String {
		return htmlToAttributedString?.string ?? ""
	}
}
