//
//  VC.swift
//  JoystickUIKit
//
//  Created by Yessen (eazel5) on 2021/12/30.
//

import UIKit
import AVFoundation

extension UIViewController {
    public func makeWeakVibration() {
        AudioServicesPlaySystemSound(1519)
    }
}
