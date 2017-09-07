
//  ViewController.swift
//  NotificationsUI

import UIKit

class ViewController: UIViewController {
    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(at: selectedDate)
    }
}
