package comnos.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String addProduct(ProductVO product, 
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		
		product.setFILE_NAME(file.getOriginalFilename());
		service.addProduct(product, file);
		
		//redirect목적지로 정보 전달
		
		return "redirect:/product/list";
	}
	
	@PostMapping("/detail")
	public ResponseEntity<ProductVO> getDetail(String productNo) {
		
		ProductVO vo = service.get(productNo);
		
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
}
