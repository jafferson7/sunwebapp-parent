//
//  StudentGradesViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 7/9/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class StudentGradesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var classes: classList = classList(gradingScale: [], assignmentList: [], courseGrades: [])
	var schoolName: String = ""

	@IBOutlet weak var studentGradesTableView: UITableView!
	@IBOutlet weak var sNameLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		studentGradesTableView.delegate = self
		studentGradesTableView.dataSource = self

		sNameLabel.text = schoolName
	}

	@IBAction func showGradingScale(_ sender: Any) {
		print("gradingscale button pressed...")
		var message = ""
		for level in self.classes.gradingScale {
			message += "\(level.low) - \(level.high): \(level.letter)\n"
		}
		let popup = UIAlertController(title: "Grading Scale", message: message, preferredStyle: .alert)
		popup.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(popup, animated: true, completion: nil)
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return classes.courseGrades.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		cell.textLabel?.text = self.classes.courseGrades[indexPath.row].courseCode

		guard let finalGrade = Int(self.classes.courseGrades[indexPath.row].finalGrade) else {
			print("cannot convert final grade!!!")
			return cell
		}

		var letterGrade = ""

		for level in self.classes.gradingScale {
			guard let levelLow = Int(level.low) else { print("cannot convert low value"); return cell}
			if finalGrade >= levelLow {
				letterGrade = level.letter
				break
			}
		}

		cell.detailTextLabel?.text = self.classes.courseGrades[indexPath.row].finalGrade + " - " + letterGrade
		cell.accessoryType = .disclosureIndicator
		cell.selectionStyle = .none
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		OperationQueue.main.addOperation {
			self.performSegue(withIdentifier: "goToGrades", sender: nil)
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Classes"
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToGrades" {
			let destinationController = segue.destination as! GradesViewController
			destinationController.classes = self.classes
			destinationController.classIndex = self.studentGradesTableView.indexPathForSelectedRow?.row ?? 0
		}
	}

}
