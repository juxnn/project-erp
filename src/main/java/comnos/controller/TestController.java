package comnos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/test/*")
@AllArgsConstructor
public class TestController {

	
	
	@GetMapping("/form")
	public void getTestForm() {
		
	}
	
	@GetMapping("/list")
	public void getTestList() {
		
	}
	
	@GetMapping("/modal")
	public void getTestModal() {
		
	}
	
	@GetMapping("/search")
	public void getTestSearch() {
		
	}
}
