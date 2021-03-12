//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Ibrahim Usmani on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let symbol = textField.text {
            
            getData(symbol: symbol)
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD&fsym="
    
    //FOUNDATION ->
    
    func getData(symbol:String){
        
        //Step 1: //Initialize the URL
        guard let url = URL(string: url) else { return }
        
        
        
        // Step 2 : initialized task and url session
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
      
            //Checking Optionals
            guard let data = data, error == nil else {return}
            
            print("Data Received!")
            
            
            do {
                
                let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                print(Result.main)
                DispatchQueue.main.async {
                    self.outputLabel.text = "\(Result.main)"
                }
            }
            
            catch {
                
                print(error.localizedDescription)
                
            }
            
            
            

            
        }
      //Step 3 : Task .Resume -> Initiate the process
        task.resume()
        
        
        
    }
    
    
    
    
    struct APIResponse : Codable {
        let main : [Result]
    }
    
    struct Result : Codable {
        
        let temp : Float
        let feels_like : Float
    }
    
}
