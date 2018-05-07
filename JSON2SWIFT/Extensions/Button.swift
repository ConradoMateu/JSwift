//
//  Button.swift
//  JSON2SWIFT
//
//  Created by Conrado Mateu Gisbert on 06/05/2018.
//  Copyright © 2018 conradomateu. All rights reserved.
//

import Cocoa

@IBDesignable
class Button: NSButton
{
    @IBInspectable var bgColor: NSColor?
    @IBInspectable var textColor: NSColor?

    override func awakeFromNib()
    {
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        
        self.attributedTitle = NSMutableAttributedString(string: "Hello World", attributes: [NSAttributedStringKey.foregroundColor: NSColor.red, NSAttributedStringKey.paragraphStyle: pstyle, NSAttributedStringKey.font: NSFont.systemFont(ofSize: 18)])


        if let textColor = textColor, let font = font
        {
            let style = NSMutableParagraphStyle()
            style.alignment = .center

            let attributes =
                [
                    NSAttributedStringKey.foregroundColor: textColor,
                    NSAttributedStringKey.font: font,
                    NSAttributedStringKey.paragraphStyle: style
                    ] as [NSAttributedStringKey : Any]

            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            self.attributedTitle = attributedTitle
        }
    }

    override func draw(_ dirtyRect: NSRect)
    {
        if let bgColor = bgColor
        {
            bgColor.setFill()
            __NSRectFill(dirtyRect)
        }

        super.draw(dirtyRect)
    }
}


