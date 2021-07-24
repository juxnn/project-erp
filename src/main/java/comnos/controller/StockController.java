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

import comnos.domain.Criteria;
import comnos.domain.EmployeeVO;
import comnos.domain.OrderVO;
import comnos.domain.ProductVO;
import comnos.domain.StockVO;
import comnos.domain.StoreVO;
import comnos.service.ComputeService;
import comnos.service.EmployeeService;
import comnos.service.ProductService;
import comnos.service.StockService;
import comnos.service.StoreOrderService;
import comnos.service.StoreOutService;
import comnos.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/stock/*")
@AllArgsConstructor
@Log4j
public class StockController {

	private StockService service;
	private EmployeeService employeeService;
	private StoreService storeService;
	private ProductService productService;
	private StoreOrderService storeOrderService;
	private StockService stockService;
	private StoreOutService storeOutService;
	private ComputeService computeService;
	
	@GetMapping("/list")
	@Transactional
	public void list(Model model) {
		
		List<StockVO> list = service.getList();
		List<StoreVO> storeList =storeService.getList();
		
		model.addAttribute("list", list);
		model.addAttribute("storeList", storeList);
	}
	
	@GetMapping("/edit")
	public void getEdit(Model model) {
		List<ProductVO> list = productService.getList();
		
		model.addAttribute("list", list);
	}

	@GetMapping("/in-form")
	public void getInForm() {
		
	}
	
	@GetMapping("/in-list")
	public void getInList(Model model) {
		List<OrderVO> list = storeOrderService.getList();
		model.addAttribute("list", list);	
	}
	
	@GetMapping("/out-form")
	@PreAuthorize("isAuthenticated()")
	@Transactional
	public void getOutForm(Principal principal, Model model, Criteria cri) {
		
		String empCodeStr = principal.getName(); 
		long empCode = Long.parseLong(empCodeStr);
		
		EmployeeVO employee = new EmployeeVO(); 
		employee = employeeService.read(empCode);
		model.addAttribute("employee", employee);
		
		List<ProductVO> productTypeList = productService.getTypeList();
		model.addAttribute("productTypeList", productTypeList);
		
		cri.setType("1");	//STATUS(1) : 승인된 애들만 가져오기.
		List<OrderVO> list = storeOrderService.getListWithPaging(cri);
		model.addAttribute("list", list);
	}
	
	@PostMapping("/search-product")
	public ResponseEntity<List<StockVO>> test(Model model, ProductVO product, Criteria cri) {
		log.info("search 메소드 실행....");
		log.info(product);
		
		List<StockVO> list = stockService.getListWithPaging(cri);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping("/submit-out")
	@Transactional
	public void submitOutOrder(OrderVO order, Principal principal) {
		
		long empCode = Long.parseLong( principal.getName() );
		
		int number = 1;
		String ono = computeService.mimeOrderNumberC(number);

		order.setORDER_NO(ono);
		order.setEMP_CODE(empCode);
		order.setSTORE_NO(order.getSTORE_NO());
		
		storeOutService.addStoreOutOrder(order);
	}
	
	@PostMapping("/complete-order")
	@Transactional
	public String completeOrder(OrderVO order, Principal principal) {
		
		long empCode = Long.parseLong( principal.getName() );
		EmployeeVO employee = employeeService.read(empCode);
		
		int number = 1;
		String ono = computeService.mimeOrderNumberC(number);
		
		storeOrderService.statusUpdate(order);		//발주서 상태(3)으로 업데이트
		
		List<OrderVO> list = storeOrderService.getOrderDetail( order.getORDER_NO() );
		//특정 (내부)발주서 PRODUCT_NO, ORDER_EA 가져오기.
	
		for(int i =0; i<list.size(); i++) {
			
			String pno = list.get(i).getPRODUCT_NO();
			int pea = list.get(i).getORDER_EA();
			
			StockVO stock = new StockVO();

			stock.setSTORE_NO(0);
			stock.setPRODUCT_NO(pno);
			int existEA = service.countEA(stock);		//기존 재고 COUNT
			
			stock.setSTORE_STOCK_EA( existEA - pea );
			
			service.update(stock);						//창고재고에서 빼준다.
			
			OrderVO out = new OrderVO();
			out.setORDER_NO(ono);
			out.setEMP_CODE(empCode);			
			out.setSTORE_NO(employee.getSTORE_NO());
			out.setPRODUCT_NO(pno);
			out.setORDER_EA(pea);
			storeOutService.addStoreOutOrder(out);	//출고서 작성
		}
		
	
		
		return "redirect:/store-order/list";
	}
	
	
	@GetMapping("/out-list")
	public void getOutList(Model model) {
		List<OrderVO> list = storeOutService.getList();
		model.addAttribute("list", list);
	}
}
