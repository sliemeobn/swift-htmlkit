//
//  SwiftHTMLKit.swift
//
//
//  Created by Evan Anderson on 10/5/24.
//

import Utilities
import SwiftHTMLKit

package struct SwiftHTMLKitTests : HTMLGenerator {
    package init() {}

    package func staticHTML() -> String {
        #html([
            #body([
                #h1(["Swift HTML Benchmarks"])
            ])
        ])
    }
    package func dynamicHTML(_ context: HTMLContext) -> String {
        let qualities:String = context.user.qualities.map({ #li(["\($0)"]) }).joined()
        return #html([
            #body([
                #h1(["\(context.heading)"]),
                #div(attributes: [.id("desc")], [
                    #p(["\(context.string)"])
                ]),
                #h2(["\(context.user.details_heading)"]),
                #h3(["\(context.user.qualities_heading)"]),
                #ul(attributes: [.id("user-qualities")], ["\(qualities)"])
            ])
        ])
    }
}