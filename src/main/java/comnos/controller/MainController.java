package comnos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/main/*")
@AllArgsConstructor
public class MainController {

	@GetMapping("/home")
	public void home() {
		
	
	}
	
}
