//
//  ViewController.swift
//  FlipWord
//
//  Created by Chris Chueh on 11/26/16.
//  Copyright © 2016 Chris Chueh. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var numberButtons = [CustomButton]()
    var dictLights: [Int:Int] = [:]
    let dark = UIImage(named: "Unlit")
    let light = UIImage(named: "Lit")
    var tag = 5
    var numberLit = 4
    var start: CGFloat = 0
    var reset: CGFloat = 0
    var width: CGFloat = 0
    
    @IBAction func addButton(_ sender: Any) {
        if (numberButtons.count == 12) {
            self.alert(title: "Warning!", message: "Too many buttons!")
        }
            
        else {
            addLight()
        }
    }

    // MARK: Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test")

        start += self.view.bounds.height / 8
        reset = start
        width += self.view.bounds.width / 6
        
        initialVC()
        refresh()
    }
    
        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    dynamic func checkStatus(_ button: CustomButton) {
        switch button.status {
        case true:
            button.status = false
            button.setImage(dark, for: UIControlState())
            numberLit -= 1
        case false:
            button.status = true
            button.setImage(light, for: UIControlState())
            button.setNeedsLayout()
            numberLit += 1
        }
    }
    
    dynamic func switchLights(_ button: CustomButton) {
        checkStatus(button)
        checkStatus(self.view.viewWithTag(dictLights[button.tag]!) as! CustomButton)
        
        if (numberLit == 0) {
            let endViewController = self.storyboard?.instantiateViewController(withIdentifier: "endViewController") as! EndViewController
            
            self.present(endViewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func assignAssociations(_ button: CustomButton) -> [Int:Int] {
        let x = Int(arc4random_uniform(UInt32(numberButtons.count)) + 1)

        if (x == button.tag) {
            _ = assignAssociations(button)
        }
            
        else {
            dictLights[button.tag] = x
        }
        
    return dictLights
    }
    
    fileprivate func initialVC() {
        for i in 1..<5 {
            let x = createButton(light!, start, width)
            numberButtons += [x]
            x.tag = i
            start += self.view.bounds.height / 8
        }
        
        start = reset
        width += self.view.bounds.width / 6
    }
    
    fileprivate func refresh() {
        for i in 0..<numberButtons.count {
            _ = assignAssociations(numberButtons[i])
        }
    }
    
    fileprivate func addLight() {
        let w = self.view.bounds.width / 6
        
        if (numberButtons.count == 8) {
            start = reset
            width += w
        }
        
        let y = createButton(light!, start, width)
        numberButtons += [y]
        y.tag = tag
        tag += 1
        numberLit += 1
        start += reset
        _ = assignAssociations(y)
    }
    
    fileprivate func createButton(_ image: UIImage,_ y: CGFloat,_ x: CGFloat) -> CustomButton {
        
        let makeButton = CustomButton()
       
        makeButton.frame = CGRect(x: x, y: y, width: 30, height: 30)
        makeButton.translatesAutoresizingMaskIntoConstraints = true
        
        self.view.addSubview(makeButton)
 
        makeButton.setImage(image, for: UIControlState())
        makeButton.addTarget(self, action: #selector(switchLights), for: .touchUpInside)
        
        return makeButton
    }
}

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
 
