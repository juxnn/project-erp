package comnos.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String addOrder(OrderVO order, String[] products, int[] ORDER_EA) {
		
		int number = 1;
		//주문번호 채번 서비스 (B01)번부터 시작		
		String ono = computeService.mimeOrderNumberB(number);
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {

			order.setPRODUCT_NO( products[i] );
			order.setORDER_EA( ORDER_EA[i] );		
			service.addOrder(order);	//내부 발주서 작성
		}
		return "redirect:/store-order/list";
	}
	
	
	@GetMapping("/list")
	public void getInOrderList(Model model) {
		List<OrderVO> list = service.getOrderList();
		model.addAttribute("list", list);	
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
