//
//  PathFinder.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 12/04/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Foundation
import Cocoa

class PathFinder {
    static func execute(withDirectory:Bool) -> URL? {
        let dialog = NSOpenPanel()
        dialog.title  = "Choose a Directory"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        if withDirectory {
            dialog.canChooseDirectories = true
            dialog.canCreateDirectories = true
            dialog.canChooseFiles = false
        }else{
            dialog.canChooseFiles = true
            dialog.canChooseDirectories = false
            dialog.canCreateDirectories = false
        }
        dialog.allowsMultipleSelection = false
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            return dialog.url
        } else {
            // User clicked on "Cancel"
            return nil
        }
    }
}
