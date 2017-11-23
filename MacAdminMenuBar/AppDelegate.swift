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

    @IBOutlet weak var showDesktopMI: NSMenuItem!
    
    @IBOutlet weak var hideDesktopMI: NSMenuItem!
    
    @IBAction func showDesktopMI(_ sender: Any){
        showdesktop(sender: Any?.self)
    }
    
    @IBAction func hideDesktopMI(_ sender: Any){
        hidedesktop(sender: (Any).self)
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = NSMenu()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "KISDColorseal_32x32"))
            //button.action = #selector(showdesktop)
        }
        menu.addItem(NSMenuItem(title: "Show Icons", action: #selector(showdesktop), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Hide Icons", action: #selector(hidedesktop), keyEquivalent: "H"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: "q"))
        
        statusItem.menu = menu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
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

        
    }
}

