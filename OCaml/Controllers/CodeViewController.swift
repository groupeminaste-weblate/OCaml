//
//  CodeViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

class CodeViewController: UIViewController, UIDocumentPickerDelegate, SyntaxTextViewDelegate {
    
    // Views
    let editor = CustomSyntaxTextView()
    let executor = OCamlExecutor()
    
    // File properties
    var currentFile: URL? { didSet { updateTitle() }}
    var edited = false { didSet { updateTitle() }}
    var loading = true

    // Load view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "code".localized()
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "doc.badge.plus"), style: .plain, target: self, action: #selector(open(_:))),
            UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc"), style: .plain, target: self, action: #selector(save(_:))),
            UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(close(_:)))
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: self, action: #selector(execute(_:)))
        ]
        
        // Setup view
        view.addSubview(editor)
        editor.setup()
        editor.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        editor.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editor.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        editor.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        editor.translatesAutoresizingMaskIntoConstraints = false
        editor.delegate = self
        
        // Add toolbar to editor
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: editor.contentTextView, action: #selector(UIResponder.resignFirstResponder))
        ]
        toolbar.sizeToFit()
        editor.contentTextView.inputAccessoryView = toolbar
    }
    
    // Update title
    func updateTitle() {
        navigationItem.title = (currentFile?.lastPathComponent ?? "code".localized()) + (edited ? " (*)" : "")
    }
    
    // Give the OCaml lexer
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
    // Listen for content change
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        // Check for loading
        if loading {
            // Mark as loaded
            self.loading = false
        } else {
            // Mark as edited
            self.edited = true
        }
    }
    
    // Get keyboard shortcuts for iPad and Mac
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "o", modifierFlags: .command, action: #selector(open(_:))),
            UIKeyCommand(input: "s", modifierFlags: .command, action: #selector(save(_:))),
            UIKeyCommand(input: "r", modifierFlags: .command, action: #selector(execute(_:)))
        ]
    }
    
    // Execute content (play button)
    @objc func execute(_ sender: Any) {
        // Get source code
        let source = self.editor.text
        
        // Compile it
        self.executor.compile(source: source) { javascript, error in
            // Check if it was compiled
            if let javascript = javascript {
                // Execute it
                self.executor.run(javascript: javascript) { entries in
                    // Process entries
                    let output = entries.map{ $0.description }.joined(separator: "\n")
                    
                    // Present output in a console view controller
                    let controller = ConsoleViewController()
                    controller.output.text = output
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            } else {
                // Handler errors
                let alert = UIAlertController(title: "error".localized(), message: nil, preferredStyle: .alert)
                switch error {
                    case .fromJS(let jsError):
                        alert.message = jsError
                    default:
                        alert.message = "error_unknown".localized()
                }
                alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Open file
    @objc func open(_ sender: Any) {
        // Create a document picker
        let picker = UIDocumentPickerViewController(documentTypes: ["public.ocaml"], in: .open)
        
        // Handle selected file
        picker.delegate = self
        
        // Show picker
        self.present(picker, animated: true, completion: nil)
    }
    
    // Save file
    @objc func save(_ sender: Any) {
        // Check if a file is opened
        if let currentFile = currentFile {
            // Start accessing a security-scoped resource.
            guard currentFile.startAccessingSecurityScopedResource() else { return }
            defer { currentFile.stopAccessingSecurityScopedResource() }
            
            // Save file content
            try? editor.text.write(to: currentFile, atomically: true, encoding: .utf8)
            self.edited = false
        } else {
            // Save document in temp folder
            let file = FileManager.default.temporaryDirectory.appendingPathComponent("source.ml")
            try? editor.text.write(to: file, atomically: true, encoding: .utf8)
            
            // Create a document picker
            let picker = UIDocumentPickerViewController(url: file, in: .moveToService)
            
            // Handle selected file
            picker.delegate = self
            
            // Show picker
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    // Close file
    @objc func close(_ sender: Any) {
        // Clear source code
        self.loading = true
        self.edited = false
        self.editor.text = ""
        
        // Close current file
        self.currentFile = nil
    }
    
    // Handle selected file
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Open
        if controller.documentPickerMode == .open, let url = urls.first {
            // Start accessing a security-scoped resource.
            guard url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            
            // Get URL
            self.currentFile = url
            
            // Open file in editor
            self.loading = true
            self.editor.text = (try? String(contentsOf: url)) ?? ""
            self.edited = false
        }
        
        // Save
        else if controller.documentPickerMode == .moveToService, let url = urls.first {
            // Start accessing a security-scoped resource.
            guard url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            
            // Save URL
            self.currentFile = url
            self.edited = false
        }
    }
    
}