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
    static func execute() -> URL?{
        let dialog = NSOpenPanel()
        dialog.title                   = "Choose a Directory";
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = true
        dialog.canCreateDirectories    = true
        dialog.allowsMultipleSelection = false
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            return dialog.url
        } else {
            // User clicked on "Cancel"
            return nil
        }
    }
}
