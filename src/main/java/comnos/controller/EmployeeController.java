package comnos.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import comnos.domain.DepartmentVO;
import comnos.domain.EmployeeVO;
import comnos.domain.RankVO;
import comnos.domain.StoreVO;
import comnos.service.EmployeeService;
import comnos.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/employee/*")
@AllArgsConstructor
@Log4j
public class EmployeeController {
	

	private EmployeeService service;
	private StoreService storeService;
 
	@RequestMapping("/login")
	public void login() {
	}
	
	@RequestMapping("/register")
	public void register(Model model) {
		
		
		  List<RankVO> rankList = service.getRankList();
		  List<DepartmentVO> deptList =service.getDeptList();
		  List<StoreVO> storeList = storeService.getList();
		  
		  model.addAttribute("storeList", storeList); model.addAttribute("rankList",
		  rankList); model.addAttribute("deptList", deptList);
		 
		
	}
	
	@PostMapping("/register")
	public String registerPost(EmployeeVO vo, RedirectAttributes rttr) {
		
		String address1 = vo.getEMP_ADDRESS();
		String address2 = vo.getEMP_ADDRESS_SUB();
		
		vo.setEMP_ADDRESS(address1+ address2);
		
		boolean ok = service.insert(vo);
		if (ok) {
			return "redirect:/employee/list";
		} else {
			return "redirect:/member/register?error";
		}
		
	}
	
	@GetMapping("/info")
	public void get(Model model) {
		
		long code = 1;
		
		EmployeeVO employee = service.read(code);
		model.addAttribute("employee", employee);
	}
	
	@GetMapping("/list")
	public void getList(Model model) {
		
		List<EmployeeVO> list = service.getList();
		
		List<RankVO> rankList = service.getRankList();
		List<DepartmentVO> deptList = service.getDeptList();
		List<StoreVO> storeList =storeService.getList();
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("rankList", rankList);
		model.addAttribute("deptList", deptList);
		
		
		model.addAttribute("list", list);
	}

	@GetMapping("/findpw")
	public void findpw() {
	}
	 
	//인증번호 발송
	@PostMapping("/sendemail")
	@ResponseBody
	public ResponseEntity<String> mailCerti(String empCode, String email){
	
		long empCodeL = Long.parseLong(empCode);
		EmployeeVO employee = service.read(empCodeL);
		
		if(employee == null) {
			
			return new ResponseEntity<>("noCode", HttpStatus.OK);
			
		}else {
			
			String empEmail = employee.getEMP_EMAIL();
			
			if(empEmail.equals(email)) {
				service.mailSend(email);
				//시간을 측정
				return new ResponseEntity<>("success", HttpStatus.OK);
				
			}else {
				return new ResponseEntity<>("noEmail", HttpStatus.OK);
			}	
		}
	}
	
	@GetMapping("/test")
	@PreAuthorize("isAuthenticated()")
	public void testMethod(Principal principal,  Model model) {
		log.info(principal.getName());
		
		String empCodeStr = principal.getName();
		long empCode = Long.parseLong(empCodeStr);
		
		EmployeeVO employee = service.read(empCode);
		model.addAttribute("employee", employee);
		
		
		//TEST
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String securePw = encoder.encode("123");
		
		String rawPassword = "1234";
		String encodedPassword = employee.getEMP_PASSWORD();
		if( encoder.matches(rawPassword, encodedPassword)) {
			log.info("비밀번호 일치");
		}else {
			log.info("비밀번호 불일치");
		}
		
		model.addAttribute("securepw", securePw);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
