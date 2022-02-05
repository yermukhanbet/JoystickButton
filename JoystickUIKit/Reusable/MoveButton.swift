//
//  MoveButton.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit

public enum MoveButtonType: String {
    case forward = "▶︎"
    case backward = "◀︎"
}

final class MoveButton: UIButton {
    
    public let type: MoveButtonType
    
    // MARK: - constructors
    
    init(title: MoveButtonType, frame: CGRect) {
        self.type = title
        super.init(frame: frame)
        self.setViews(title: title.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 1.0) {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    // MARK: - Setting the view
    
    private func setViews(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2666666667, blue: 0.3058823529, alpha: 1)
    }
    
    // MARK: - selection/unselection
    
    public func setSelected() {
        self.titleLabel?.font = .systemFont(ofSize: 40)
        self.isSelected = true
    }
    
    public func setUnselected() {
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.isSelected = false
    }
}

final class JoystickCenterButton: UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 1.0) {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    private func setViews() {
        self.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2666666667, blue: 0.3058823529, alpha: 1)
        self.setTitle("0", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 80)
        self.titleLabel?.textColor = #colorLiteral(red: 0.5882352941, green: 0.6549019608, blue: 0.6862745098, alpha: 1)
        
        self.setShadow()
    }
    
    private func setShadow() {
        self.layer.borderColor = #colorLiteral(red: 0.1019607843, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 1.5
    }
}
