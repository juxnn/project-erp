package comnos.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import comnos.domain.EmployeeVO;
import comnos.domain.OrderVO;
import comnos.domain.ProductVO;
import comnos.service.ComputeService;
import comnos.service.EmployeeService;
import comnos.service.ProductService;
import comnos.service.StoreOrderService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/store-order/*")
@AllArgsConstructor
@Log4j
public class StoreOrderController {
	
	private StoreOrderService service;
	private ProductService productService;
	private EmployeeService employeeService;
	private ComputeService computeService;
	
	
	@GetMapping("/form")
	@PreAuthorize("isAuthenticated()")
	@Transactional
	public void getOrderForm(Model model, Principal principal) {
		
		
		String empCodeStr = principal.getName(); 
		long empCode = Long.parseLong(empCodeStr);
		
		EmployeeVO employee = new EmployeeVO(); 
		employee = employeeService.read(empCode);
		model.addAttribute("employee", employee);
		
		List<ProductVO> list = productService.getList();
		List<ProductVO> productTypeList = productService.getTypeList();
		
		model.addAttribute("list", list);
		model.addAttribute("productTypeList", productTypeList);
	}
	
	@PostMapping("/order")
	@Transactional
	public String addOrder(OrderVO order, String[] products, int[] ORDER_EA, RedirectAttributes rttr) {
		
		//발주수량 유효성 검사(상품의 발주량이 0개인 경우가 있으면 에러 메세지처리)
		for(int i=0; i<products.length; i++) {
			if(ORDER_EA[i] == 0) {
				rttr.addFlashAttribute("message", "수량이 0개인 상품이 있습니다.");
				return "redirect:/store-order/order";
			}
		}
		
		int number = 1;
		//주문번호 채번 서비스 (B01)번부터 시작		
		String ono = computeService.mimeOrderNumberB(number);
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {
			order.setPRODUCT_NO( products[i] );
			order.setORDER_EA( ORDER_EA[i] );
			service.addOrder(order);	//내부 발주서 작성
		}
		rttr.addFlashAttribute("message", "발주서 제출이 되었습니다.");
		return "redirect:/store-order/list";
	}
	
	
	@GetMapping("/list")
	public void getInOrderList(Model model, RedirectAttributes rttr) {
		List<OrderVO> list = service.getOrderList();
		model.addAttribute("list", list);	
//		model.addAttribute("message", rttr.getFlashAttributes().get("message"));
	}
	
	@PostMapping("/detail")
	public ResponseEntity<List<OrderVO>> getInOrderDetail(String ono) {
		
		List<OrderVO> list = service.getOrderDetail(ono);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@PostMapping("/status-update")
	public String statusUpdate2(OrderVO order) {
		
		service.statusUpdate(order);//(내부)발주서 업데이트
		return "redirect:/store-order/list";
	}

}
