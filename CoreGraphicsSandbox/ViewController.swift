//
//  ViewController.swift
//  CoreGraphicsSandbox
//
//  Created by Paul Richardson on 13/06/2021.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	var currentDrawType = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		drawRectangle()
	}

	@IBAction func redrawTapped(_ sender: Any) {
		currentDrawType += 1
		if currentDrawType > 5 {
			currentDrawType = 0
		}
		switch currentDrawType {
		case 0:
			drawRectangle()
		default:
			break
		}
	}

	func drawRectangle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			//
		}

		imageView.image = image

	}
	
}

