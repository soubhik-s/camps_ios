//
//  CustomSegmentedControl.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 13/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

public class CustomSegmentedControl: UIControl {

    public var borderWidth: CGFloat = 1.0
    public var selectedSegementIndex = 0 {
        didSet {
            self.styleButtons()
        }
    }

    public var numberOfSegments: Int {
        return self.segments.count
    }

    private var buttons: [UIButton] = []
    private var stackView = UIStackView(frame: CGRect.zero)
    private var stackBackground = UIView(frame: CGRect.zero)
    private var segments: [NSAttributedString] = [] {
        didSet {
            for subview in self.stackView.arrangedSubviews {
                subview.removeFromSuperview()
            }
            self.buttons = []
            for i in 0..<segments.count {
                let segment = segments[i]
                self.createAndAddSegmentButton(title: segment)
            }
            self.styleButtons()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {

        self.addSubview(stackBackground)
        self.stackBackground.constrainToBounds(of: self)
        self.addSubview(stackView)
        self.stackView.constrainToBounds(of: self)
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = borderWidth

        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        self.stackBackground.backgroundColor = tintColor
    }

    private func createAndAddSegmentButton(title: NSAttributedString) {
        let button = createSegmentButton(title: title)
        self.buttons.append(button)
        self.stackView.addArrangedSubview(button)
    }

    private func createSegmentButton(title: NSAttributedString) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(self.actSelected(button:)), for: .touchUpInside)
        return button
    }

    override public var tintColor: UIColor! {
        willSet {
            self.layer.borderColor = newValue.cgColor
            self.stackBackground.backgroundColor = newValue
        }
    }

    public func setSegments(_ segments: [NSAttributedString]) {
        self.segments = segments
    }

    @objc private func actSelected(button: UIButton) {
        guard let index = self.buttons.index(of: button) else {
            print("invalid selection should never happen, would want to handle better than this")
            return
        }
        self.selectedSegementIndex = index
        self.sendActions(for: .valueChanged)
    }

    private func styleButtons() {
        for i in 0..<self.buttons.count {
            let button = self.buttons[i]
            if i == selectedSegementIndex {
                button.backgroundColor = self.tintColor
                button.titleLabel?.textColor = self.backgroundColor ?? .white
            } else {
                button.backgroundColor = self.backgroundColor
                button.titleLabel?.textColor = self.tintColor
            }
        }
    }
}
