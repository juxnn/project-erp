package comnos.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import comnos.service.ComputeService;
import comnos.service.EmployeeService;
import comnos.service.OrderService;
import comnos.service.ProductService;
import comnos.service.StockService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
@Log4j
public class OrderController {

	private OrderService service;
	private EmployeeService employeeService;
	private ProductService productService;
	private StockService stockService;
	private ComputeService computeService;
	
	
	@GetMapping("/form")
	@PreAuthorize("isAuthenticated()")
	public void orderForm(Principal principal, Model model) {
		
		
		String empCodeStr = principal.getName();
		long empCode = Long.parseLong(empCodeStr);
		
		EmployeeVO employee = employeeService.read(empCode);
		
		List<ProductVO> list = productService.getList();
		List<ProductVO> productTypeList = productService.getTypeList();
		
		model.addAttribute("employee", employee);
		model.addAttribute("list", list);
		model.addAttribute("productTypeList", productTypeList);
		
		
		
		
	}
	
	@PostMapping("/add")
	@Transactional
	public String addOrder(OrderVO order, String[] products, int[] ORDER_EA) {
		
		int number = 1;
		//주문번호 채번 서비스 (A01)번부터 시작
		String ono = computeService.mimeOrderNumberA(number);
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {
			
			order.setPRODUCT_NO( products[i] );
			order.setORDER_EA( ORDER_EA[i] );
			service.addOutOrder(order);		//외부 발주서 작성
		}
		return "redirect:/order/list";
	}
	
	@GetMapping("/list")
	public void orderList(Model model) {
		List<OrderVO> list = service.getOutList();
		model.addAttribute("list", list);	
	}
	
	@PostMapping("/search-product")
	public ResponseEntity<List<ProductVO>> test(Model model, ProductVO product, Criteria cri) {
		log.info("search 메소드 실행....");
		log.info(product);
		
		String type = product.getPRODUCT_TYPE();
		String no = product.getPRODUCT_NO();
		String name = product.getPRODUCT_NAME();
		
		cri.setType(type);
		cri.setKeyword1(no);
		cri.setKeyword2(name);
		
		List<ProductVO> list = productService.getListWithPaging(cri);
//		model.addAttribute("list", list);
//		ajax로 실행시.. 모델에 reuqest가 아니라 값이 전달이 잘 안되는것 같다.
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping("/detail")
	public ResponseEntity<List<OrderVO>> getOrderDetail(String ono) {
		
		List<OrderVO> list = service.getOrderDetail(ono);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}


	@PostMapping("/status-update")
	@Transactional
	public String statusUpdate(OrderVO order) {
		
		//발주서 업데이트
		service.statusUpdate(order);
		
		int status = order.getORDER_STATUS();
		
		//발주 통과(1)
		if(status == 1) {
			//발주번호의 상품들을 전부 가져온다.
			String ono = order.getORDER_NO();
			List<OrderVO> list = service.getOrderDetail(ono);
			
			//하나씩 넣어준다.
			for(int i=0; i<list.size(); i++) {
			
				
				OrderVO vo = list.get(i);
				String pno = vo.getPRODUCT_NO();	// 발주서의 상품번호[i]
				int orderEA = vo.getORDER_EA();		// 발주서의 주문갯수[i]
													// 기존 재고랑 합쳐야하는 작업이 필요하다.
				
				StockVO stock = new StockVO();
				
				stock.setSTORE_NO(0);						// 창고(=0)
				stock.setPRODUCT_NO(pno);					// 상품번호[i]	
				
				int stockEA =  stockService.countEA(stock);	// 창고의 기존 재고를 가져온다.
			
				int totalEA = orderEA + stockEA;			// 총 재고 = 승인된 주문 + 기존 재고
				stock.setSTORE_STOCK_EA(totalEA);			
				
				stockService.update(stock);					//재고 업데이트
			}	
		//발주반려(2)	
		}else {
			
		}
		return "redirect:/order/list";
	}
	

	
	
	
}
