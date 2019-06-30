//
//  StudentInfoViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 6/29/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import Eureka
import UIKit

class StudentInfoViewController: FormViewController {

	var currStudent: student = student.init(id: "0", name: "")

	override func viewDidLoad() {
		super.viewDidLoad()

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
			}

			<<< TextRow() { row in
				row.title = "Middle Initial"
//				row.placeholder = ""
				row.value = currStudent.middleInitial
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
	}

	@IBAction func saveInfo(_ sender: Any) {
		print("save stuff here")

	}
}
