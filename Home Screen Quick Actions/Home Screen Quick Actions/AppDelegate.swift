//
//  AppDelegate.swift
//  Home Screen Quick Actions
//
//  Created by 马卿 on 16/9/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Types
    
    enum ShortcutIdentifier: String {
        case First
        case Second
        case Third
        case Fourth
        
        // MARK: - Initializers
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        // MARK: - Properties
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    // MARK: - Static Properties
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    // MARK: - Properties
    var window: UIWindow?

    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1 (static).
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2 (static).
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3 (dynamic).
            handled = true
            break
        case ShortcutIdentifier.Fourth.type:
            // Handle shortcut 4 (dynamic).
            handled = true
            break
        default:
            break
        }
        
        // Construct an alert using the details of the shortcut used to open the application.
        let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        // Display an alert indicating the shortcut selected from the home screen.
        window!.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        
        return handled
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        
        // Install initial versions of our two extra dynamic shortcuts.
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            // Construct the items.
            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Third.type, localizedTitle: "Play", localizedSubtitle: "Will Play an item", icon: UIApplicationShortcutIcon(type: .Play), userInfo: [
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Play.rawValue
                ]
            )
            
            let shortcut4 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Fourth.type, localizedTitle: "Pause", localizedSubtitle: "Will Pause an item", icon: UIApplicationShortcutIcon(type: .Pause), userInfo: [
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Pause.rawValue
                ]
            )
            
            // Update the application providing the initial 'dynamic' shortcut items.
            application.shortcutItems = [shortcut3, shortcut4]
        }
        
        return shouldPerformAdditionalDelegateHandling
        
    }
    /**
      运用激活：当点击 快捷方式进入app
     
     */
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        
        launchedShortcutItem = nil
    }


    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }

}

