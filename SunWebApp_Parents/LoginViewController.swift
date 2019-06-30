//
//  LoginViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 5/1/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import UIKit

struct student: Decodable {
	let id: String
	var name: String
	var firstName: String
	var middleInitial: String
	var lastName: String
	let grade: String
	var gender: String
	var birthday: String
	var comments: String
	var foodAllergies: String
	var healthCondition: String

//	"id":"63","name":"Mariam M Jaffer","Fname":"Mariam","MIni":"M","Lname":"Jaffer","grade":"K","gender":"F","DOB":"","Comments":"na","FoodAllergies":"na","HealthCondition":"na"

	private enum CodingKeys : String, CodingKey {
		case id
		case name
		case firstName = "Fname"
		case middleInitial = "MIni"
		case lastName = "Lname"
		case grade = "grade"
		case gender = "gender"
		case birthday = "DOB"
		case comments = "Comments"
		case foodAllergies = "FoodAllergies"
		case healthCondition = "HealthCondition"
	}

	init(id: String = "0",
		name: String = "",
		firstName: String = "",
		middleInitial: String = "",
		lastName: String = "",
		grade: String = "",
		gender: String = "",
		birthday: String = "",
		comments: String = "",
		foodAllergies: String = "",
		healthCondition: String = "") {
		self.id = id
		self.name = name
		self.firstName = firstName
		self.middleInitial = middleInitial
		self.lastName = lastName
		self.grade = grade
		self.gender = gender
		self.birthday = birthday
		self.comments = comments
		self.foodAllergies = foodAllergies
		self.healthCondition = healthCondition
	}
}

struct loginResult: Decodable {
	var p1: String
	var p2: String
	var names: [student]
	var pmsg: String

	private enum CodingKeys : String, CodingKey {
		case p1
		case p2
		case names
		case pmsg
	}

	init(p1: String = "",
		p2: String = "",
		names: [student] = [],
		pmsg: String = "") {
		self.p1 = p1
		self.p2 = p2
		self.names = names
		self.pmsg = pmsg
	}
}

class LoginViewController: UIViewController {

	@IBOutlet weak var schoolCodeTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

//	https://sunwebapp.com/app/GetParentiPhone.php?Scode=sdf786ic&SchoolCode=demo&salt=mmjaffer@yahoo.com&pepper=MJaffer
	var loginURL = "https://sunwebapp.com/app/GetParentiPhone.php?Scode=sdf786ic&SchoolCode="
//	let loginURL = URL.init(string: "https://sunwebapp.com/app/GetParentiPhone.php?")!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	var familyInfo : loginResult = loginResult(p1: "", p2: "", names: [], pmsg: "")

	@IBAction func loginButtonClicked(_ sender: Any) {
		loginURL += (schoolCodeTextField.text ?? "demo")
		loginURL += "&salt=" + (emailTextField.text ?? "mmjaffer@yahoo.com")
		loginURL += "&pepper=" + (passwordTextField.text ?? "MJaffer")
		guard let url = URL(string: loginURL) else {return}
		loginURL = "https://sunwebapp.com/app/GetParentiPhone.php?Scode=sdf786ic&SchoolCode="

		print(url)

		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
			}

			guard let data = data else { return }

			do {
				let decoder = JSONDecoder()
				self.familyInfo = try decoder.decode(loginResult.self, from: data)
				print(self.familyInfo.names[0].name)

				if self.familyInfo.p1 != "none" && self.familyInfo.p2 != "none" {
					DispatchQueue.main.async {
						UserDefaults.standard.set(self.schoolCodeTextField.text, forKey: "schoolCode")
						UserDefaults.standard.set(self.familyInfo.p1 + ", " + self.familyInfo.p2, forKey: "name")
					}
					OperationQueue.main.addOperation {
						self.performSegue(withIdentifier: "loginSegue", sender: self.familyInfo)
					}
				}
			} catch let jsonError {
				print(jsonError)
			}
		}.resume()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "loginSegue" {
			let barViewControllers = segue.destination as! UITabBarController
			let navigationViewController = barViewControllers.viewControllers?[0] as! UINavigationController
			let destinationViewController = navigationViewController.topViewController as! StudentListViewController
			destinationViewController.familyInfo = self.familyInfo
		}
	}

}

extension URLRequest {
	/// Set body and header for x-www-form-urlencoded request
	///
	/// - Parameter parameters: Simple string dictionary of parameters to be encoded in body of request

	mutating func setContent(with parameters: [String: String]) {
		setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

		let array = parameters.map { entry -> String in
			let key = entry.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
			let value = entry.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
			return key + "=" + value
		}
		httpBody = array.joined(separator: "&").data(using: .utf8)!
	}
}

extension CharacterSet {

	/// Returns the character set for characters allowed in the individual parameters within a query URL component.
	///
	/// The query component of a URL is the component immediately following a question mark (?).
	/// For example, in the URL `http://www.example.com/index.php?key1=value1#jumpLink`, the query
	/// component is `key1=value1`. The individual parameters of that query would be the key `key1`
	/// and its associated value `value1`.
	///
	/// According to RFC 3986, the set of unreserved characters includes
	///
	/// `ALPHA / DIGIT / "-" / "." / "_" / "~"`
	///
	/// In section 3.4 of the RFC, it further recommends adding `/` and `?` to the list of unescaped characters
	/// for the sake of compatibility with some erroneous implementations, so this routine also allows those
	/// to pass unescaped.

	static var urlQueryValueAllowed: CharacterSet = {
		let generalDelimitersToEncode = ":#[]@"    // does not include "?" or "/" due to RFC 3986 - Section 3.4
		let subDelimitersToEncode = "!$&'()*+,;="

		var allowed = CharacterSet.urlQueryAllowed
		allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
		return allowed
	}()
}
