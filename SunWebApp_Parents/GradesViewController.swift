//
//  GradesViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 6/5/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

class GradesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var classes: classList = classList(gradingScale: [], assignmentList: [], courseGrades: [])

	var classIndex: Int = 0

	@IBOutlet weak var gradeTableView: UITableView!
	@IBOutlet weak var gradesToolbar: UIToolbar!

	@IBAction func showComments(_ sender: Any) {
		let comment = UIAlertController(title: "Comments", message: self.classes.courseGrades[classIndex].comments, preferredStyle: .alert)
		comment.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(comment, animated: true, completion: nil)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.classes.courseGrades[classIndex].grades.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = self.classes.assignmentList[indexPath.row].name
		cell.detailTextLabel?.text = self.classes.courseGrades[classIndex].grades[indexPath.row]

		return cell
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		gradeTableView.dataSource = self
		gradeTableView.delegate = self

		print(self.classes.courseGrades[classIndex].grades.count)
		navigationItem.title = self.classes.courseGrades[classIndex].courseName
		if self.classes.courseGrades[classIndex].comments == "" || true {
			gradesToolbar.isHidden = true
		}
	}
}
