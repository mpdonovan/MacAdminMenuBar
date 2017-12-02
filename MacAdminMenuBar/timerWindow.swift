//
//  timerWindow.swift
//  MacAdminMenuBar
//
//  Created by Donovan, Mike on 12/1/17.
//  Copyright © 2017 Donovan, Mike. All rights reserved.
//

import Cocoa

protocol TimerWindowDelegate {
    func timerDidUpdate()
}

class TimerWindow: NSWindowController, NSWindowDelegate {
    var delegate: TimerWindowDelegate?
    @IBOutlet weak var cityTextField: NSTextField!
    
//    override var windowNibName : String! {
//        return "TimerWindow"
//    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        //let defaults = UserDefaults.standard
        //let city = defaults.string(forKey: "city") ?? DEFAULT_CITY
        //cityTextField.stringValue = city
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(cityTextField.stringValue, forKey: "city")
        delegate?.timerDidUpdate()
    }
}
