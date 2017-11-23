//
//  EventMonitor.swift
//  MacAdminMenuBar
//
//  Created by Donovan, Mike on 11/23/17.
//  Copyright © 2017 Donovan, Mike. All rights reserved.
//

import Cocoa

class EventMonitor {
    private var monitor: AnyObject?
    private var mask: NSEvent.EventTypeMask
    private var handler: (NSEvent?) -> ()
    
    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()){
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start(){
        
    }
    
    func stop(){
        
    }
}
