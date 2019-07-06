//
//  MessageDetailViewController.swift
//  SunWebApp_Parents
//
//  Created by Usmaan Jaffer on 7/5/19.
//  Copyright © 2019 SunWebApp. All rights reserved.
//

import Eureka
import UIKit

class MessageDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var messageTableView: UITableView!

	var currMessage: message = message.init(id: "", from: "", subject: "", message: "", attachment: "", Ccode: "", timestamp: "")

	override func viewDidLoad() {
		super.viewDidLoad()

		messageTableView.delegate = self
		messageTableView.dataSource = self
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		switch indexPath.row {
		case 0:
			cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
			cell.textLabel?.text = currMessage.from
		case 1:
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
			cell.textLabel?.text = currMessage.subject
			cell.detailTextLabel?.text = currMessage.timestamp
		case 2:
			cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
			cell.textLabel?.text = currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString + currMessage.message.htmlToString
			cell.textLabel?.numberOfLines = 0
		default:
			cell.textLabel?.text = ""
			cell.detailTextLabel?.text = ""
		}

		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}
