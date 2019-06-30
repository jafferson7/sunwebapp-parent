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

	override func viewDidLoad() {
		super.viewDidLoad()

		form
			+++ Section("Student Info")
			<<< TextRow(){ row in
				row.title = "First Name"
				row.placeholder = "LeBron"
			}

			<<< TextRow() { row in
				row.title = "Middle Initial"
				row.placeholder = ""
			}

			<<< TextRow() { row in
				row.title = "Last Name"
				row.placeholder = "James"
			}

			<<< LabelRow() { row in
				row.title = "Grade"
				row.value = "LAL"
			}

			<<< PickerInputRow<String>("") {
				$0.title = "Gender"
				$0.options = ["Male", "Female"]
				$0.value = $0.options.first
			}

			<<< DateRow() {
				$0.value = Date()
				$0.title = "DOB (MM/DD/YYYY)"
			}

			+++ Section("Special Instructions")
			<<< TextAreaRow("Special Instructions") {
				$0.placeholder = "Special Instructions"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnBlur
			}

			+++ Section("Food Allergies")
			<<< TextAreaRow("Food Allergies") {
				$0.placeholder = "Food Allergies"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnBlur
			}

			+++ Section("Health Conditions")
			<<< TextAreaRow("Health Conditions") {
				$0.placeholder = "Health Conditions"
				$0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
				$0.add(rule: RuleMaxLength(maxLength: 100))
				$0.validationOptions = .validatesOnBlur
			}
	}

}
