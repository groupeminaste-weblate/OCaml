//
//  OCamlCourse.swift
//  OCaml
//
//  Created by Nathan FALLET on 06/01/2021.
//

import Foundation

class OCamlCourse {
    
    // Course content
    static let content = [
        // Basics
        LearnSequence(title: "sequence_basics", elements: [
            // Discover
            LearnChapter(title: "chapter_discover_title", elements: [
                LearnTitle(content: "chapter_discover_title"),
                LearnParagraph(content: "chapter_discover_welcome"),
                LearnCode(content: """
                    (* \("chapter_discover_comment".localized()) *)
                    print_endline "Hello, world!";;
                    """),
                LearnParagraph(content: "chapter_discover_first"),
                LearnParagraph(content: "chapter_discover_second")
            ]),
            
            // Variables
            LearnChapter(title: "chapter_variables_title", elements: [
                LearnTitle(content: "chapter_variables_def"),
                LearnParagraph(content: "chapter_variables_intro"),
                LearnCode(content: """
                    let x = 3;;
                    """),
                LearnParagraph(content: "chapter_variables_def_global"),
                LearnParagraph(content: "chapter_variables_def_local"),
                LearnCode(content: """
                    (* \("chapter_variables_def_local_comment1".localized()) *)
                    let x = 3 in
                    x + 4;;

                    (* \("chapter_variables_def_local_comment2".localized()) *)
                    x + 4;;
                    """),
                LearnParagraph(content: "chapter_variables_def_local2"),
                LearnTitle(content: "chapter_variables_types"),
                LearnParagraph(content: "chapter_variables_types_intro"),
                LearnCode(content: """
                    let x = 3;; (* int *)
                    let y = 3.0;; (* float *)
                    let test = true;; (* bool *)
                    let txt = "Hello";; (* string *)
                    let a = 'a';; (* char *)
                    let empty = ();; (* unit *)
                    """),
                LearnParagraph(content: "chapter_variables_types_description"),
                LearnTitle(content: "chapter_variables_references"),
                LearnParagraph(content: "chapter_variables_references_intro"),
                LearnCode(content: """
                    let x = ref 3;;
                    """),
                LearnParagraph(content: "chapter_variables_references_def"),
                LearnCode(content: """
                    let x = ref 3;;
                    
                    x := 4;; (* 1 *)
                    
                    x;; (* 2 *)
                    
                    !x;; (* 3 *)
                    """),
                LearnParagraph(content: "chapter_variables_references_details"),
            ]),
            
            // Operations on numbers
            LearnChapter(title: "chapter_operations_title", elements: [
                LearnTitle(content: "chapter_operations_integers"),
                LearnParagraph(content: "chapter_operations_integers_intro"),
                LearnCode(content: """
                    let a = 2 + 3 - 1;; (* a = 4 *)
                    let b = 7 * 4;; (* b = 28 *)
                    let c = 7 / 4;; (* c = 1 *)
                    let d = 7 mod 4;; (* d = 3 *)
                    """),
                LearnTitle(content: "chapter_operations_floats"),
                LearnParagraph(content: "chapter_operations_floats_intro"),
                LearnCode(content: """
                    let a = 2.7 +. 3.2 -. 0.5;; (* a = 5.4 *)
                    let b = 1.7 *. 0.2 /. 0.1;; (* b = 3.4 *)
                    let c = 9.0 **. 0.5;; (* c = 3.0 *)
                    """),
                LearnTitle(content: "chapter_operations_funcs"),
                LearnParagraph(content: "chapter_operations_funcs_intro"),
                LearnCode(content: """
                    let a = cos 0.0 +. sin 1.0 -. tan 3.14;; (* a = 1.84... *)
                    let b = asin 1.0 *. acos 1.0 /. atan 1.0;; (* b = 0.0 *)
                    let c = sinh 2.4;; (* c = 5.46... *)
                    let d = exp 1.0;; (* d = 2.71... *)
                    let e = log 2.0;; (* e = 0.69... *)
                    let f = log10 2.0;; (* f = 0.30... *)
                    """),
                LearnTitle(content: "chapter_operations_print"),
                LearnParagraph(content: "chapter_operations_print_intro"),
                LearnCode(content: """
                    let a = 2 + 3 - 1 in
                    print_endline (string_of_int a);;
                    let b = 2.7 +. 3.2 -. 0.5 in
                    print_endline (string_of_float b);;
                    """),
            ]),
            
            // Conditions
            
            // Loops
            
            // Arrays
            
            // Strings
            
            // Functions
            
        ])
    ]
    
}
