//
//  ViewController.swift
//  MyNoteBook
//
//  Created by Ali Al sharefi on 14/02/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var savedText = "type here"
    var currentIndex = -1
    //array
    var textArray = [String]() //we initalize an empty string
    
    var fileName = "textDoucument.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textArray.append("Hello")
        textArray.append("How are you")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTextField.text = savedText
    }

    @IBAction func buttonPressed(_ sender: Any) {
        savedText = myTextField.text!
        
        if (currentIndex == -1){
            
            textArray.append(savedText)
            
        }else{
                textArray[currentIndex] = savedText
                currentIndex = -1
        }
        //textArray.append(savedText)
        tableView.reloadData()
        myTextField.text = ""
        //print(savedText)
        
        saveString(str: savedText, filename: fileName)
        
        print(readStringFromFile(fileName:fileName))
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTextField.text = textArray[indexPath.row]
        currentIndex = indexPath.row
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        if (currentIndex != -1){
            textArray.remove(at: currentIndex)
            tableView.reloadData()
            currentIndex = -1
        }
        
    }
    
    func saveString(str: String, filename:String){
        
        let filePath = getDocumentdir().appendingPathComponent(filename)
        
        do{
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("ok writing string \(str)")
            
        }catch{
            
            print("Printing string error!")
        }
       
        
    }
    
    func getDocumentdir() -> URL{
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return documentDir[0]
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentdir().appendingPathComponent(fileName)

        do{
            let string = try String(contentsOf: filePath, encoding: .utf8)
            
            return string
            
        }catch{
            
            print("While reading this" + fileName)
        
        }
        
        return ""
    }
    
    
}

