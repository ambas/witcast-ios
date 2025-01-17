/*
 * Copyright (C) 2015 - 2017, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material

class FeedToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    fileprivate var searchButton: IconButton!
    
    open override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareSearchButton()
        prepareStatusBar()
        prepareToolbar()
    }
}

extension FeedToolbarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .black)
        menuButton.pulseColor = .white
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search, tintColor: .black)
        searchButton.pulseColor = .white
    }
    
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
        statusBar.backgroundColor = CustomFunc.UIColorFromRGB(rgbValue: colorMain)
    }
    
    fileprivate func prepareToolbar() {
        menuButton.tag = 0
        searchButton.tag = 1

        toolbar.backgroundColor = CustomFunc.UIColorFromRGB(rgbValue: colorMain)
        toolbar.leftViews = [menuButton]
        toolbar.rightViews = [searchButton]
        
        toolbar.titleLabel.isUserInteractionEnabled = true // Remember to do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        toolbar.titleLabel.addGestureRecognizer(tap)
        
        menuButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func buttonAction(sender: UIButton!) {
        if sender.tag == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "menu"), object: nil)
        }
        else {
            let vc = AppSearchBarController(rootViewController: SearchViewController(nibName: "SearchViewController", bundle: nil))
            navigationController?.pushViewController(vc, animated: true);
        }
    }
    
    func didTapLabel(sender: UITapGestureRecognizer)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gotoTop"), object: nil)
    }
}
