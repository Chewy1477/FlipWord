//
//  ViewController.swift
//  FlipWord
//
//  Created by Chris Chueh on 11/26/16.
//  Copyright © 2016 Chris Chueh. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var numberButtons = [Button]()
    var dictLights: [Int:Int] = [:]
    let dark = UIImage(named: "Unlit")
    let light = UIImage(named: "Lit")
    var v1: CGFloat = 25
    var p1: CGFloat = 210
    var p2: CGFloat = 215
    var tag = 5
    var numberLit = 4

    @IBAction func addButton(sender: AnyObject) {
        if (numberButtons.count == 8) {
            self.alert("Warning!", message: "Too many buttons!")
        }
        
        else {
            addLight(p1, p2: p2)
            p1 += 20
            p2 += 83
        }
    }
    
    // MARK: Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialVC()
        refresh()
        
    }
    
        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    dynamic func checkStatus(button: Button) {
        switch button.status! {
        case true:
            button.status = false
            button.setImage(dark, forState: .Normal)
            numberLit -= 1
        case false:
            button.status = true
            button.setImage(light, forState: .Normal)
            button.setNeedsLayout()
            numberLit += 1
        }
    }
    
    dynamic func test(button: Button) {
        checkStatus(button)
        checkStatus(self.view.viewWithTag(dictLights[button.tag]!) as! Button)
        
        if (numberLit == 0) {
            let endViewController = self.storyboard?.instantiateViewControllerWithIdentifier("endViewController") as! EndViewController
            
            self.presentViewController(endViewController, animated: true, completion: nil)
        }
        
    }
    
    private func changeLights(button: Button) -> [Int:Int] {
        let x = Int(arc4random_uniform(UInt32(numberButtons.count)) + 1)

        if (x == button.tag) {
            changeLights(button)
        }
            
        else {
            dictLights[button.tag] = x
        }
        
    return dictLights
        
    }
    
    private func initialVC() {
        var z1: CGFloat = 25
        var z2: CGFloat = 465
        for i in 1..<5 {
            let x = createButton(light!, x: z1, y: z2)
            z1 += 15
            z2 -= 83
            numberButtons += [x]
            x.tag = i
        }
    }
    
    private func refresh() {
        for i in 0..<numberButtons.count {
            self.view.addSubview(numberButtons[i])
            changeLights(numberButtons[i])
        }

    }
    
    private func addLight(p1: CGFloat, p2: CGFloat) {
        let y = createButton(light!, x: p1, y: p2)
        numberButtons += [y]
        self.view.addSubview(y)
        y.tag = tag
        tag += 1
        numberLit += 1
        changeLights(y)
    }
        
    
    
    private func createButton(image: UIImage, x: CGFloat, y: CGFloat) -> Button {
        let makeButton = Button()
        makeButton.frame = CGRectMake(x, y, 20, 20)
        makeButton.setImage(image, forState: .Normal)
        makeButton.addTarget(self, action: #selector(test), forControlEvents: .TouchUpInside)
        
        return makeButton
    
    }
}

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
 