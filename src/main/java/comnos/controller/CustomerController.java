package comnos.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import comnos.domain.CustomerVO;
import comnos.service.CustomerService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/customer/*")
@AllArgsConstructor
@Log4j
public class CustomerController {

	private CustomerService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		
		List<CustomerVO> list = service.getList();
		model.addAttribute("list", list);
	}
	
	@GetMapping("/add")
	public void getCustomerAddForm() {
		
	}
	
	@PostMapping("/add")
	public String addCustomer(CustomerVO customer) {
		service.addCustomer(customer);
		
		return "redirect:/customer/list";
	}
}
