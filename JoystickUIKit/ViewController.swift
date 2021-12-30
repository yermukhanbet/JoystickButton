//
//  ViewController.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Components
    
    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private lazy var buttonsHV = UIStackView()
    
    private lazy var nextButton = MoveButton(title: "▶︎", frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private lazy var previousButton = MoveButton(title: "◀︎", frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.setViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createJoystick()
    }
    
    // MARK: - UI Layout
    
    private func setViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(centerButton)
        centerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.createHVButtons()
    }
    
    private func createHVButtons() {
        let views: [UIView] = [self.previousButton, self.nextButton]
        self.buttonsHV = UIStackView(arrangedSubviews: views)
        self.buttonsHV.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 50)
        self.buttonsHV.axis = .horizontal
        self.buttonsHV.distribution = .equalSpacing
    }
    
    private func createJoystick() {
        self.centerButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(joystickHold)))
    }
}

// MARK: - Joystick functions

extension ViewController {
    
    @objc private func joystickHold(gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.showMoveButtons()
        case .ended:
            self.hideMoveButtons()
        case .changed:
            self.userMovedFinger(to: gesture.location(in: self.buttonsHV))
        default:
            break
        }
    }
    
    private func showMoveButtons() {
        self.view.addSubview(buttonsHV)
        let centerX = (self.view.frame.width - self.buttonsHV.frame.width) / 2
        buttonsHV.transform = CGAffineTransform(translationX: centerX, y: self.centerButton.frame.minY)
        
        //for animation
        buttonsHV.alpha = 0.0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.buttonsHV.alpha = 1
        }
    }
    
    private func userMovedFinger(to location: CGPoint) {
        let hitTest = self.buttonsHV.hitTest(location, with: nil)
        self.unselectAllButtons()
        if let selectedButton = hitTest as? MoveButton  {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                selectedButton.setSelected()
            }
        }
    }
    
    private func hideMoveButtons() {
        self.unselectAllButtons { [unowned self] (_) in
            self.buttonsHV.removeFromSuperview()
        }
    }
    
    private func unselectAllButtons(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.buttonsHV.subviews.forEach({ (button) in
                guard let joystickButton = button as? MoveButton else { return }
                joystickButton.setUnselected()
            })
        }, completion: completion)
    }
}

