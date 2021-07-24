package comnos.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import comnos.domain.ProductVO;
import comnos.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product/*")
@AllArgsConstructor
@Log4j
public class ProductController {

	private ProductService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("product/list method....");
		
		List<ProductVO> list = service.getList();
		
		model.addAttribute("list", list);		
		
	}
	
	@GetMapping("/add")
	public void getProductAddForm() {
		
	}
	
	@PostMapping("/add")
	public String addProduct(ProductVO product) {
		service.addProduct(product);
		
		return "redirect:/product/list";
	}
}
