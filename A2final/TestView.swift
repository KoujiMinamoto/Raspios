//
//  TestView.swift
//  A2final
//
//  Created by KoujiMinamoto on 28/9/19.
//  Copyright © 2019 Monash. All rights reserved.
//

import UIKit

class TestView: UIViewController,DatabaseListener {
    weak var databaseController: DatabaseProtocol?
    
    static var isAlreadyLaunchedOnce = false
        
    @IBOutlet weak var test1: UILabel!
    @IBOutlet weak var test2: UILabel!
    @IBOutlet weak var test3: UILabel!
    @IBOutlet weak var test4: UILabel!
    @IBOutlet weak var test5: UILabel!
    @IBOutlet weak var test6: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     databaseController?.removeListener(listener: self)
     }
    
     // MARK: - Database Listener

    var listenerType = ListenerType.all


     func ontestListChange(change: DatabaseChange, test: [test]) {
     let aTest = test[0]
        test1.text = String(aTest.Red)
        test2.text = String(aTest.Green)
        test3.text = String(aTest.Blue)
        test4.text = String(aTest.clear)
        test5.text = String(aTest.preesure)
        test6.text = String(aTest.tem)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

