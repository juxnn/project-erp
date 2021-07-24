package comnos.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import comnos.domain.StoreVO;
import comnos.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/store/*")
@AllArgsConstructor
@Log4j
public class StoreController {

	private StoreService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		
		List<StoreVO> list = service.getList();
		
		model.addAttribute("list", list);
	}
	
	@GetMapping("/add")
	public void getStoreAddForm() {
		
	}
	
	@PostMapping("/add")
	public String addStore(StoreVO store){
		service.addStore(store);
		
		return "redirect:/store/list";
	}
}
