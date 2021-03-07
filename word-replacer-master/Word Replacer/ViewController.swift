//
//  ViewController.swift
//  Word Replacer
//
//  Created by admin on 05.03.2021.
//  Copyright © 2021 Charles. All rights reserved.
//

import Cocoa
import SafariServices

class ViewController: NSViewController, NSWindowDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
        self.view.window?.styleMask = [NSWindow.StyleMask.closable, NSWindow.StyleMask.titled, NSWindow.StyleMask.miniaturizable]
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
    @IBAction func onShowPreferencesClicked(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: BundleIDForExtension) { (error) in
            if let error = error {
                print("Error launching the extension's preferences: %@", error)
            }
        }
    }


}

