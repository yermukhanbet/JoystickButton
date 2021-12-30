//
//  ViewController.swift
//  JoystickUIKit
//
//  Created by Yessen (eazel5) on 2021/12/30.
//

import UIKit


class ViewController: UIViewController {
    
    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private lazy var buttonsHV = UIStackView()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setTitle("▶︎", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setTitle("◀︎", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0.5
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
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
        print(self.nextButton.frame.height)
        print(self.nextButton.frame.width)
    }
    
    private func hideMoveButtons() {
        self.buttonsHV.removeFromSuperview()
    }
}

