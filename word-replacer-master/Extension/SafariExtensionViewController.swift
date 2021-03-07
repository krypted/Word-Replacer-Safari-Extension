//
//  SafariExtensionViewController.swift
//  Extension
//
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var inputOriginal: NSTextField!
    @IBOutlet weak var inputNew: NSTextField!
    @IBOutlet weak var `switch`: NSSwitch!
    
    let TAG_WR_ORIGINAL = 0
    let TAG_WR_NEW = 1
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:150)
        return shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputOriginal.delegate = self
        self.inputNew.delegate = self
    }
    
    @IBAction func onSwitchChanged(_ sender: NSSwitch) {
        UserDefaults.standard.set(sender.state.rawValue, forKey: WR_ON)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        let textField: NSTextField = obj.object as! NSTextField
        
        if textField.tag == TAG_WR_ORIGINAL {
            UserDefaults.standard.set(textField.stringValue, forKey: WR_ORIGINAL)
        }
        
        if textField.tag == TAG_WR_NEW {
            UserDefaults.standard.set(textField.stringValue, forKey: WR_NEW)
        }
        
    }
    
}
