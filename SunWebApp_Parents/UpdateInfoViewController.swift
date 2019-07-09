//
//  StudentInfoViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 6/29/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import Eureka
import UIKit

class UpdateInfoViewController: FormViewController {

	var currStudent: student = student.init(id: "0", name: "")

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.backBarButtonItem?.title = "Back"

		let studentBirthday = DateFormatter()
		studentBirthday.dateFormat = "MM/dd/yyyy"
//		print(studentBirthday.date(from: currStudent.birthday))

		LabelRow.defaultCellUpdate = { cell, row in
//			cell.contentView.backgroundColor = .red
			cell.textLabel?.textColor = .white
//			cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
//			cell.textLabel?.textAlignment = .right

		}

		TextRow.defaultCellUpdate = { cell, row in
			if !row.isValid {
				cell.titleLabel?.textColor = .red
			}
		}

		form
			+++ Section("Student Info")
			<<< TextRow(){ row in
				row.title = "First Name"
				row.placeholder = "Required"
				row.value = currStudent.firstName
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChangeAfterBlurred
			}
			.onChange { row in
				self.currStudent.firstName = row.value ?? ""
			}

			<<< TextRow() { row in
				row.title = "Middle Initial"
//				row.placeholder = ""
				row.value = currStudent.middleInitial
			}
			.onChange { row in
					self.currStudent.middleInitial = row.value ?? ""
			}

			<<< TextRow() { row in
				row.title = "Last Name"
				row.placeholder = "Required"
				row.value = currStudent.lastName
				row.add(rule: RuleRequired())
			}
			.cellUpdate { cell, row in
				if !row.isValid {
					cell.titleLabel?.textColor = .red
				}
			}
			.onChange { row in
				self.currStudent.lastName = row.value ?? ""
			}

			<<< LabelRow() { row in
				row.title = "Grade"
				row.value = currStudent.grade
			}
			.cellUpdate { cell, row in
				cell.textLabel?.textColor = .black
//				cell.detailTextLabel?.textColor = .black
			}

			<<< PickerInputRow<String>("Gender") {
				$0.title = "Gender"
				$0.options = ["Male", "Female"]
				$0.value = currStudent.gender == "M" ? "Male" : "Female"
				$0.add(rule: RuleRequired())
			}
			.onChange { row in
				self.currStudent.gender = String(row.value?.prefix(1) ?? "")
			}

			<<< DateRow() {
				$0.value = studentBirthday.date(from: currStudent.birthday)
				$0.title = "DOB (MM/DD/YYYY)"
				$0.add(rule: RuleRequired())
				$0.validationOptions = .validatesAlways
			}
			.onRowValidationChanged { cell, row in
				let rowIndex = row.indexPath!.row
				while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
					row.section?.remove(at: rowIndex + 1)
				}
				if !row.isValid {
					for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
						let labelRow = LabelRow() {
							$0.title = validationMsg
							$0.cell.height = { 30 }
							$0.cell.textLabel?.textColor = .white
							$0.cell.backgroundColor = .red
							$0.cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
							$0.cell.textLabel?.textAlignment = .right
						}
						let indexPath = row.indexPath!.row + index + 1
						row.section?.insert(labelRow, at: indexPath)
					}
				}
			}
			.onChange { row in
				self.currStudent.birthday = studentBirthday.string(from: row.value ?? Date())
			}

			+++ Section("Special Instructions")
			<<< TextAreaRow("Special Instructions") {
				$0.placeholder = "Special Instructions"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnChange
				$0.value = currStudent.comments
			}
			.onRowValidationChanged { cell, row in
				let rowIndex = row.indexPath!.row
				while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
					row.section?.remove(at: rowIndex + 1)
				}
				if !row.isValid {
					for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
						let labelRow = LabelRow() {
							$0.title = validationMsg
							$0.cell.height = { 30 }
							$0.cell.textLabel?.textColor = .white
							$0.cell.backgroundColor = .red
							$0.cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
							$0.cell.textLabel?.textAlignment = .right
						}
						let indexPath = row.indexPath!.row + index + 1
						row.section?.insert(labelRow, at: indexPath)
					}
				}
			}
			.onChange { row in
				self.currStudent.comments = row.value ?? ""
			}

			+++ Section("Food Allergies")
			<<< TextAreaRow("Food Allergies") {
				$0.placeholder = "Food Allergies"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnDemand
				$0.value = currStudent.foodAllergies
			}
			.onRowValidationChanged { cell, row in
				let rowIndex = row.indexPath!.row
				while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
					row.section?.remove(at: rowIndex + 1)
				}
				if !row.isValid {
					for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
						let labelRow = LabelRow() {
							$0.title = validationMsg
							$0.cell.height = { 30 }
							$0.cell.textLabel?.textColor = .white
							$0.cell.backgroundColor = .red
							$0.cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
							$0.cell.textLabel?.textAlignment = .right
						}
						let indexPath = row.indexPath!.row + index + 1
						row.section?.insert(labelRow, at: indexPath)
					}
				}
			}
			.onChange { row in
				self.currStudent.foodAllergies = row.value ?? ""
			}

			+++ Section("Health Conditions")
			<<< TextAreaRow("Health Conditions") {
				$0.placeholder = "Health Conditions"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnDemand
				$0.value = currStudent.healthCondition
			}
			.onRowValidationChanged { cell, row in
				let rowIndex = row.indexPath!.row
				while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
					row.section?.remove(at: rowIndex + 1)
				}
				if !row.isValid {
					for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
						let labelRow = LabelRow() {
							$0.title = validationMsg
							$0.cell.height = { 30 }
							$0.cell.textLabel?.textColor = .white
							$0.cell.backgroundColor = .red
							$0.cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
							$0.cell.textLabel?.textAlignment = .right
						}
						let indexPath = row.indexPath!.row + index + 1
						row.section?.insert(labelRow, at: indexPath)
					}
				}
			}
			.onChange { row in
				self.currStudent.healthCondition = row.value ?? ""
			}

	}

	@IBAction func saveInfo(_ sender: Any) {
		print("save stuff here")
		let validationErrors = form.validate()

		if validationErrors.count > 0 {
			let message = "Please complete the required fields"
			let alert = UIAlertController(title: "Missing Fields", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			return
		}

		var saveInfoURL = "https://sunwebapp.com/app/SaveStudentInfoiPhone.php?Scode=sdf786ic&SchoolCode="
		saveInfoURL += UserDefaults.standard.string(forKey: "schoolCode") ?? "demo"
		saveInfoURL += "&id=" + currStudent.id
		saveInfoURL += "&Fname=" + currStudent.firstName
		saveInfoURL += "&Mini=" + currStudent.middleInitial
		saveInfoURL += "&Lname=" + currStudent.lastName
		saveInfoURL += "&grade=" + currStudent.grade
		saveInfoURL += "&gender=" + currStudent.gender
		saveInfoURL += "&DOB=" + currStudent.birthday
		saveInfoURL += "&comments=" + currStudent.comments
		saveInfoURL += "&FoodAllergies=" + currStudent.foodAllergies
		saveInfoURL += "&HealthCondition=" + currStudent.healthCondition


		guard let url = URL(string: saveInfoURL) else {return}
		print(url)

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
			}

			guard let data = data else {return}

			do {
				let decoder = JSONDecoder()
				print("going to decode now...")
				self.currStudent.name = try decoder.decode(Dictionary<String, String>.self, from: data).first?.value ?? ""
				print("decode done \(self.currStudent.name)")
			} catch let jsonError {
				print(jsonError)
			}
		}.resume()
		let message = "Save successful for \(self.currStudent.name)"
		let alert = UIAlertController(title: "Admin Message", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
