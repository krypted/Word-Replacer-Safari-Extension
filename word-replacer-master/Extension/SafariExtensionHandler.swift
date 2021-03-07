//
//  SafariExtensionHandler.swift
//  Extension
//
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
        
        let isOn = UserDefaults.standard.bool(forKey: WR_ON)
        
        if (messageName == WR_LOADED && isOn) {
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.getActiveTab(completionHandler: { (activeTab) in
                    activeTab?.getActivePage(completionHandler: { (activePage) in
                        activePage?.dispatchMessageToScript(withName: WR_REPLACE, userInfo: [
                            WR_ORIGINAL : UserDefaults.standard.string(forKey: WR_ORIGINAL) ?? "",
                            WR_NEW : UserDefaults.standard.string(forKey: WR_NEW) ?? ""
                        ])
                    })
                })
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
