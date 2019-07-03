//
//  ClassListViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

struct gradingScaleValue: Decodable {
	var letter: String
	var low: String
	var high: String

	private enum CodingKeys: String, CodingKey {
		case letter
		case low
		case high
	}

	init(letter: String = "",
		 low: String = "",
		 high: String = "") {
		self.letter = letter
		self.low = low
		self.high = high
	}
}

struct assignment: Decodable {
	var term: String
	var name: String
	var weight: String
	var points: String

	private enum CodingKeys: String, CodingKey {
		case term
		case name
		case weight
		case points
	}

	init(term: String = "",
		 name: String = "",
		 weight: String = "",
		 points: String = "") {
		self.term = term
		self.name = name
		self.weight = weight
		self.points = points
	}
}

struct courseGrade: Decodable {
	var courseCode: String
	var courseName: String
	var finalGrade: String
	var grades: [String]
	var comments: String

	private enum CodingKeys: String, CodingKey {
		case courseCode = "Ccode"
		case courseName = "Cname"
		case finalGrade = "FinalG"
		case grades
		case comments
	}

	init(courseCode: String = "",
		 courseName: String = "",
		 finalGrade: String = "",
		 grades: [String] = [],
		 comments: String = "") {
		self.courseCode = courseCode
		self.courseName = courseName
		self.finalGrade = finalGrade
		self.grades = grades
		self.comments = comments
	}
}

struct classList: Decodable {
	var gradingScale: [gradingScaleValue]
	var assignmentList: [assignment]
	var courseGrades: [courseGrade]

	private enum CodingKeys: String, CodingKey {
		case gradingScale
		case assignmentList = "gradeBook"
		case courseGrades
	}

	init(gradingScale: [gradingScaleValue] = [],
		 assignmentList: [assignment] = [],
		 courseGrades: [courseGrade] = []) {
		self.gradingScale = gradingScale
		self.assignmentList = assignmentList
		self.courseGrades = courseGrades
	}
}

struct message: Decodable {
	var id: String
	var from: String
	var subject: String
	var message: String
	var attachment: String
	var Ccode: String
	var timestamp: String

	private enum CodingKeys: String, CodingKey {
		case id
		case from
		case subject
		case message
		case attachment
		case Ccode
		case timestamp
	}

	init(id: String = "",
		 from: String = "",
		 subject: String = "",
		 message: String = "",
		 attachment: String = "",
		 Ccode: String = "",
		 timestamp: String = "") {
		self.id = id
		self.from = from
		self.subject = subject
		self.message = message
		self.attachment = attachment
		self.Ccode = Ccode
		self.timestamp = timestamp
	}
}

class ClassListViewController: UIViewController,
	UITableViewDataSource, UITableViewDelegate {

	var classListURL = "https://sunwebapp.com/app/GetStudentGradesiPhone.php?Scode=sdf786ic&SchoolCode="

	var classTitle: String = "Class List"

	var currStudent: student = student.init(id: "0", name: "")

	var classes: classList = classList(gradingScale: [], assignmentList: [], courseGrades: [])

	var gradingScale: [gradingScaleValue] = []

	var messageList: [message] = []

	@IBOutlet weak var classListTableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()

		classListTableView.delegate = self
		classListTableView.dataSource = self

		navigationItem.title = currStudent.name

		loadClassList()
		loadMessages()
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

	func loadClassList() -> Void {
		print("starting to load class list...")
		classListURL += UserDefaults.standard.string(forKey: "schoolCode") ?? "demo"
		classListURL += "&Sid=" + currStudent.id
		guard let url = URL(string: classListURL) else {return}
		print(url)

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
			}

			guard let data = data else {return}

			do {
				let decoder = JSONDecoder()
				print("going to decode now...")
				self.classes = try decoder.decode(classList.self, from: data)
				print("decode done " + self.classes.gradingScale[0].letter)
				DispatchQueue.main.async {
					self.classListTableView.reloadData()
				}
			} catch let jsonError {
				print(jsonError)
			}
		}.resume()
	}

	func loadMessages() -> Void {
		print("loading messages...")
		var messageURL = "https://sunwebapp.com/app/GetStudentMessagesiPhone.php?Scode=sdf786ic&SchoolCode="
		messageURL += UserDefaults.standard.string(forKey: "schoolCode") ?? "demo"
		messageURL += "&Sid=" + currStudent.id

		guard let url = URL(string: messageURL) else {return}
		print(url)

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
			}

			guard let data = data else {return}

			do {
				let decoder = JSONDecoder()
				print("going to decode now...")
				self.messageList = try decoder.decode([message].self, from: data)
				print("decode done for messages")
			} catch let jsonError {
				print(jsonError)
			}
		}.resume()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 1
		case 1:
			return self.classes.courseGrades.count
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		switch indexPath.section {
		case 0:
			cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
			cell.textLabel?.text = "Update Info"
			cell.selectionStyle = .none
//			tableView.style
		case 1:
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
		default:
			cell.textLabel?.text = "Default"
		}

		cell.accessoryType = .disclosureIndicator
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			print("UPDATE INFO")
			OperationQueue.main.addOperation {
				self.performSegue(withIdentifier: "StudentInfoViewControllerSegue", sender: nil)
			}
		case 1:
			OperationQueue.main.addOperation {
				self.performSegue(withIdentifier: "goToGrades", sender: nil)
			}
		default:
			print("Default!!")
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return ""
		case 1:
			return "Classes"
		default:
			return ""
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToGrades" {
			let destinationController = segue.destination as! GradesViewController
			destinationController.classes = self.classes
			destinationController.classIndex = self.classListTableView.indexPathForSelectedRow?.row ?? 0
		}
		else if segue.identifier == "StudentInfoViewControllerSegue" {
			print(self.currStudent.firstName)
			let destinationController = segue.destination as! StudentInfoViewController
			destinationController.currStudent = self.currStudent

		}
	}
}
