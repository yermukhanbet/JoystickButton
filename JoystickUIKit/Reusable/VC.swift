//
//  VC.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit
import AVFoundation

extension UIViewController {
    public func makeWeakVibration() {
        AudioServicesPlaySystemSound(1519)
    }
}
