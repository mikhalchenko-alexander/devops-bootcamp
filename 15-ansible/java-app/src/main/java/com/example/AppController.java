package com.example;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {

    @GetMapping("/")
    public ResponseEntity getData() {
        return ResponseEntity.ok("It really works! Or is it?");
    }

}
