//
//  AppDelegate.swift
//  MacAdminMenuBar
//
//  Created by Donovan, Mike on 11/22/17.
//  Copyright © 2017 Donovan, Mike. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = NSMenu()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "KISDColorseal_32x32"))
            //button.action = #selector(showdesktop)
        }

        menu.addItem(NSMenuItem(title: "Show Icons", action: #selector(showdesktop), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Hide Icons", action: #selector(hidedesktop), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Text Display", action: #selector(getBHT), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: ""))

        statusItem.menu = menu
        menu.autoenablesItems = false
        
        // Called so the application starts in a known state
        showdesktop(sender: AnyObject.self)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
    }
    
    @objc func quit(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }

    @objc func showdesktop(sender: Any?) {
        //print("Show Desktop")
        // Show Desktop icons
        let writeProcess = Process()
        writeProcess.launchPath = "/usr/bin/env"
        writeProcess.arguments = ["defaults", "write", "com.apple.finder", "CreateDesktop", "true"]
        
        writeProcess.launch()
        writeProcess.waitUntilExit()
        
        let dockProcess = Process()
        dockProcess.launchPath = "/usr/bin/env"
        dockProcess.arguments = ["killall", "Finder"]
        
        dockProcess.launch()
        dockProcess.waitUntilExit()
        
        //Alternate enabled menu items
        menu.item(withTitle: "Show Icons")?.isEnabled = false
        menu.item(withTitle: "Hide Icons")?.isEnabled = true
        
    }

    @objc func hidedesktop(sender: Any?) {
        //print("Hide Desktop")
        // Hide Desktop Icons
        let writeProcess = Process()
        writeProcess.launchPath = "/usr/bin/env"
        writeProcess.arguments = ["defaults", "write", "com.apple.finder", "CreateDesktop", "false"]
        
        writeProcess.launch()
        writeProcess.waitUntilExit()
        
        let dockProcess = Process()
        dockProcess.launchPath = "/usr/bin/env"
        dockProcess.arguments = ["killall", "Finder"]
        
        dockProcess.launch()
        dockProcess.waitUntilExit()

        //Alternate enabled menu items
        menu.item(withTitle: "Show Icons")?.isEnabled = true
        menu.item(withTitle: "Hide Icons")?.isEnabled = false
    }
    // This function takes the users input and passes it to BigHonkingText
    @objc func getBHT(sender: Any?) {
        
        let bundle = Bundle.main
        let bhtPath = bundle.path(forResource: "BigHonkingText", ofType: "")
        
        let myString = getString(title: "BigHonkingText by John Kitzmiller", question: "Enter text to be displayed.\nClick OK\nClick text to dismiss.", defaultValue: "BigHonkingText")
        
        if (myString != "Cancel") {
            let myText = " " + myString + " "
            
            let writeProcess = Process()
            writeProcess.launchPath = bhtPath
            writeProcess.arguments = ["-p", "0",myText]
            
            writeProcess.launch()
            writeProcess.waitUntilExit()
        }
        
        
    }
    // This functions gets the users input and passes it to the calling function
    @objc func getString(title: String, question: String, defaultValue: String) -> String {
        let msg = NSAlert()
        msg.addButton(withTitle: "OK")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = title
        msg.informativeText = question
    
        let txt = NSTextField(frame: NSRect(x: 0, y: 0, width: 250, height: 24))
        txt.stringValue = defaultValue
    
        msg.accessoryView = txt
        let response: NSApplication.ModalResponse = msg.runModal()
    
        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            return txt.stringValue
        } else {
            return "Cancel"
        }
    }
}

