package comnos.controller;

import java.security.Principal;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestParam;

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
import comnos.service.StoreInService;
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
	private StoreInService storeInService;
	private ComputeService computeService;
	
	@GetMapping("/list")
	@Transactional
	public void list(Model model) {
		
		
		//List<StockVO> list = service.getList();
		List<StoreVO> storeList =storeService.getList();
		List<ProductVO> productTypeList = productService.getTypeList();
		
		//model.addAttribute("list", list);
		model.addAttribute("storeList", storeList);
		model.addAttribute("productTypeList", productTypeList);
	}
	
	@PostMapping("/search")
	public ResponseEntity<List<StockVO>> searchStock(StockVO vo){
		
		List<StockVO> list = service.serach(vo);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	
	@GetMapping("/edit")
	public void getEdit(Model model) {
		List<ProductVO> list = productService.getList();
		
		model.addAttribute("list", list);
	}

	@GetMapping("/in-form")
	@PreAuthorize("isAuthenticated()")
	@Transactional
	public void getInForm(Principal principal, Model model) {
		
		long empCode = Long.parseLong( principal.getName() );
		
		EmployeeVO employee = employeeService.read(empCode);
		List<ProductVO> list = productService.getList();
		List<ProductVO> productTypeList = productService.getTypeList();
		
		model.addAttribute("employee", employee);
		model.addAttribute("list", list);
		model.addAttribute("productTypeList", productTypeList);
		
	}
	
	@GetMapping("/in-list")
	public void getInList(Principal principal, Model model) {
		
		long empCode = Long.parseLong( principal.getName() );
		EmployeeVO employee = employeeService.read(empCode);
		
		int storeNo = employee.getSTORE_NO();
		
		List<OrderVO> inList = storeInService.getListOrder(storeNo);

		model.addAttribute("inList", inList);
	}
	
	
	@PostMapping("/in-list-detail")
	public ResponseEntity<List<OrderVO>> getInListDetail(String ono) {
		
		List<OrderVO> order = storeInService.getDetail(ono);
		
		return new ResponseEntity<>(order, HttpStatus.OK);
		
	}
	
	@PostMapping("/out-list-detail")
	public ResponseEntity<List<OrderVO>> getOutListDetail(String ono) {
		
		List<OrderVO> order = storeOutService.getDetail(ono);
		
		return new ResponseEntity<>(order, HttpStatus.OK);
		
	}
	
	
	
	
	
	@PostMapping("/in-submit")
	@PreAuthorize("isAuthenticated()")
	@Transactional
	public String submit(String products[], int inEA[], OrderVO order, Principal principal) {
		
		long empCode = Long.parseLong( principal.getName() );
		order.setEMP_CODE(empCode);
		
		int number = 1;
		String ono = computeService.mimeOrderNumberD(number);		
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {
			order.setPRODUCT_NO(products[i]);
			order.setORDER_EA(inEA[i]);
			storeInService.insert(order);				//????????? ??????

			StockVO stock = new StockVO();
			stock.setPRODUCT_NO(products[i]);
			stock.setSTORE_NO(order.getSTORE_NO());
			
			int existEA = service.countEA(stock);		//?????? ?????? COUNT
			int updateEA = existEA + inEA[i];
			
			stock.setSTORE_STOCK_EA(updateEA);
			service.update(stock);				//??????????????? ????????????.
		}
		return "redirect:/stock/in-list";
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
		
		cri.setType("1");	//STATUS(1) : ????????? ????????? ????????????.
		List<OrderVO> list = storeOrderService.getListWithPaging(cri);
		List<StoreVO> storeList =storeService.getList();
		List<ProductVO> productTypeList = productService.getTypeList();
		
		
		model.addAttribute("list", list);
		model.addAttribute("storeList", storeList);
		model.addAttribute("productTypeList", productTypeList);		
	}
	
	@PostMapping("/search-product")
	public ResponseEntity<List<StockVO>> test(Model model, ProductVO product, Criteria cri) {
		log.info("search ????????? ??????....");
		log.info(product);
		
		List<StockVO> list = stockService.getListWithPaging(cri);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping("/out-submit")
	@Transactional
	public ResponseEntity<String> submitOutOrder(@RequestParam("products[]") String[] products, @RequestParam("outEA[]") int[] outEA, OrderVO order, Principal principal) {

		log.info(Arrays.toString(products));
		log.info(Arrays.toString(outEA));
		
		long empCode = Long.parseLong( principal.getName() );
		
		int number = 1;
		String ono = computeService.mimeOrderNumberC(number);
		order.setORDER_NO(ono);
		order.setEMP_CODE(empCode);
		
		for(int i=0; i<products.length; i++) {
			order.setPRODUCT_NO(products[i]);
			order.setORDER_EA(outEA[i]);
			storeOutService.addStoreOutOrder(order);				//????????? ??????

			StockVO stock = new StockVO();
			stock.setPRODUCT_NO(products[i]);
			stock.setSTORE_NO(order.getSTORE_NO());
			
			int existEA = service.countEA(stock);		//?????? ?????? COUNT
			int updateEA = existEA - outEA[i];
			
			stock.setSTORE_STOCK_EA(updateEA);
			service.update(stock);				//??????????????? ?????????.
		}
		
		return new ResponseEntity<>(HttpStatus.OK);
//		storeOutService.addStoreOutOrder(order);
	}
	
	@PostMapping("/complete-order")
	@Transactional
	public String completeOrder(OrderVO order, Principal principal) {
		
		long empCode = Long.parseLong( principal.getName() );
		EmployeeVO employee = employeeService.read(empCode);
		
		int number = 1;
		String ono = computeService.mimeOrderNumberC(number);
		
		storeOrderService.statusUpdate(order);		//????????? ??????(3)?????? ????????????
		
		List<OrderVO> list = storeOrderService.getOrderDetail( order.getORDER_NO() );
		//?????? (??????)????????? PRODUCT_NO, ORDER_EA ????????????.
	
		for(int i =0; i<list.size(); i++) {
			
			String pno = list.get(i).getPRODUCT_NO();
			int pea = list.get(i).getORDER_EA();
			
			
			
			StockVO stock = new StockVO();
			stock.setPRODUCT_NO(pno);
			stock.setSTORE_NO(0);
			int existEA = service.countEA(stock);		//????????? ?????? ?????? COUNT
			
			int updateEA =  existEA - pea;
			stock.setSTORE_STOCK_EA(updateEA);
			service.update(stock);			//?????????????????? ?????????.
			
			OrderVO out = new OrderVO();
			out.setORDER_NO(ono);
			out.setEMP_CODE(empCode);			
			out.setSTORE_NO(employee.getSTORE_NO());
			out.setPRODUCT_NO(pno);
			out.setORDER_EA(pea);
			storeOutService.addStoreOutOrder(out);	//????????? ??????
		}
		return "redirect:/store-order/list";
	}
	
	
	@GetMapping("/out-list")
	public void getOutList(Model model) {
		List<OrderVO> list = storeOutService.getList();
		model.addAttribute("list", list);
	}
}
