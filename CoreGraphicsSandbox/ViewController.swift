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
		drawLegacyCircle()

	}

	@IBAction func redrawTapped(_ sender: Any) {
		currentDrawType += 1
		if currentDrawType > 5 {
			currentDrawType = 0
		}
		switch currentDrawType {
		case 0:
			drawRectangle()
		case 1:
			drawCircle()
		case 2:
			drawCheckerboard()
		case 3:
			drawRotatedSquares()
		case 4:
			drawLines()
		case 5:
			drawNeutralFaceEmoji()
		case 6:
			drawTwin()
		case 7:
			drawLegacyCircle()
		default:
			break
		}
	}

	func drawRectangle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

			ctx.cgContext.setFillColor(UIColor.red.cgColor)
			ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
			ctx.cgContext.setLineWidth(10)

			ctx.cgContext.addRect(rectangle)
			ctx.cgContext.drawPath(using: .fillStroke)
		}

		imageView.image = image

	}

	func drawCircle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

			ctx.cgContext.setFillColor(UIColor.red.cgColor)
			ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
			ctx.cgContext.setLineWidth(10)

			ctx.cgContext.addEllipse(in: rectangle)
			ctx.cgContext.drawPath(using: .fillStroke)
		}

		imageView.image = image

	}

	// TODO: you can actually make checkerboards using a Core Image filter – check out CICheckerboardGenerator to see how!
	func drawCheckerboard() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor.black.cgColor)

			for row in 0 ..< 8 {
				for col in 0 ..< 8 {
					if (row + col).isMultiple(of: 2) {
						ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64	))
					}
				}
			}
		}

		imageView.image = image

	}

	func drawRotatedSquares() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			ctx.cgContext.translateBy(x: 256, y: 256)
			let rotations = 16
			let amount = Double.pi / Double(rotations)

			for _ in 0 ..< rotations {
				ctx.cgContext.rotate(by: CGFloat(amount))
				ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
			}
			ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
			ctx.cgContext.strokePath()
		}

		imageView.image = image

	}

	func drawLines() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			ctx.cgContext.translateBy(x: 256, y: 256)
			var first = true
			var length: CGFloat = 256

			for _ in 0 ..< 256 {
				ctx.cgContext.rotate(by: .pi / 2)
				if first {
					ctx.cgContext.move(to: CGPoint(x: length, y: 50))
					first = false
					} else {
						ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
					}
				length *= 0.99
			}

			ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
			ctx.cgContext.strokePath()
		}

		imageView.image = image

	}

	func drawNeutralFaceEmoji() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in
			ctx.cgContext.translateBy(x: 256, y: 256)

			// face

			let rectangle = CGRect(x: -256, y: -256, width: 512, height: 512).insetBy(dx: 5, dy: 5)
			ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
			ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
			ctx.cgContext.setLineWidth(10)
			ctx.cgContext.addEllipse(in: rectangle)

			ctx.cgContext.drawPath(using: .fillStroke)

			// mouth

			ctx.cgContext.setStrokeColor(UIColor.brown.cgColor)

			let mouthLength = 200
			ctx.cgContext.move(to: CGPoint(x: -mouthLength / 2, y: 100))
			ctx.cgContext.addLine(to: CGPoint(x: mouthLength / 2, y: 100))

			ctx.cgContext.drawPath(using: .stroke)

			// eyes

			let eyeSize = CGSize(width: 50, height: 75)

			ctx.cgContext.setFillColor(UIColor.brown.cgColor)
			let leftEye = CGRect(origin: CGPoint(x: -eyeSize.width * 2, y: -100), size: eyeSize)
			let rightEye = CGRect(origin: CGPoint(x: eyeSize.width, y: -100), size: eyeSize)
			ctx.cgContext.addEllipse(in: leftEye)
			ctx.cgContext.addEllipse(in: rightEye)

			ctx.cgContext.drawPath(using: .fill)

		}

		imageView.image = image

	}

	func drawTwin() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

		let image = renderer.image { ctx in

			let lineWidth: CGFloat = 15
			let em: CGFloat = lineWidth * 5
			let en = em / 2
			let looseKern = em / 4 + lineWidth
			let tightKern = en / 4 + lineWidth
			let height = en * 3

			var start = CGPoint(x: lineWidth, y: em)

			let context = ctx.cgContext
			context.setStrokeColor(UIColor.blue.cgColor)
			context.setLineJoin(.round)
			context.setLineCap(.round)
			context.setLineWidth(lineWidth)

			// T
			context.move(to: start)
			context.addLine(to: CGPoint(x: start.x + em, y: start.y) )
			context.move(to: CGPoint(x: start.x + en, y: start.y))
			context.addLine(to: CGPoint(x: start.x + en, y: start.y + height))

			// W
			start.x = start.x + em + looseKern
			context.move(to: start)
			context.addLine(to: CGPoint(x: start.x + en / 2, y: start.y + height))
			context.addLine(to: CGPoint(x: start.x + en, y: start.y))
			context.addLine(to: CGPoint(x: start.x + (em * 0.75), y: start.y + height))
			context.addLine(to: CGPoint(x: start.x + em, y: start.y))

			// I
			start.x = start.x + em + looseKern
			context.move(to: start)
			context.addLine(to: CGPoint(x: start.x, y: start.y + height))

			// N
			start.x = start.x + lineWidth + tightKern
			context.move(to: start)
			context.addLine(to: CGPoint(x: start.x, y: start.y + height))
			context.move(to: start)
			context.addLine(to: CGPoint(x: start.x + em, y: start.y + height))
			context.addLine(to: CGPoint(x: start.x + em, y: start.y))

			context.drawPath(using: .stroke)

		}

		imageView.image = image
	}

	func drawLegacyCircle() {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 0)

		if let ctx = UIGraphicsGetCurrentContext() {
			ctx.setFillColor(UIColor.red.cgColor)
			ctx.setStrokeColor(UIColor.green.cgColor)
			ctx.setLineWidth(10)

			let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
			ctx.addEllipse(in: rectangle)
			ctx.drawPath(using: .fillStroke)
		}

		if let img = UIGraphicsGetImageFromCurrentImageContext() {
			imageView.image = img
		}

		UIGraphicsEndImageContext()
	}

}

