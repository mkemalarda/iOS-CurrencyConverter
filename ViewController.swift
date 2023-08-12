//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mustafa Kemal ARDA on 12.08.2023.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func rateButton(_ sender: Any) {
        
        // Step 1 -> Request & Session
        // Step 2 -> Response & Data
        // Step 3 -> Parsing & JSON Serialization
        
        
        // Step 1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=b4249c9147332bce4436dafe15f5bf2f")
        
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
                
            } else {
                
                // Step 2
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let turkishlira = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(turkishlira)"
                                }
                                
                            }
                            
                        }
                        
                        
                    } catch {
                        print("error!")
                    }
                    
                    
                    
                }
            }
        }
        
        task.resume()
        
        
    }
    
}

