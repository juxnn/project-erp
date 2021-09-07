package comnos.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import comnos.domain.DepartmentVO;
import comnos.domain.EmployeeVO;
import comnos.domain.RankVO;
import comnos.domain.StoreVO;
import comnos.service.ComputeService;
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
	private ComputeService computeService;
 
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
		
		vo.setEMP_ADDRESS(address1+ " " +address2);
		
		boolean ok = service.insert(vo);
		if (ok) {
			return "redirect:/employee/list";
		} else {
			return "redirect:/employee/register?error";
		}
	}
	
	@PostMapping("/mime-code")
	public ResponseEntity<Long> mimeEmpCode(Date empDate) {
		
		log.info(empDate);
		
		long empCode = computeService.mimeEmpCode(empDate);
		
		return new ResponseEntity<>(empCode, HttpStatus.OK);
	}
	
	@GetMapping("/info")
	public void get(Model model) {
		
		long code = 1;
		
		EmployeeVO employee = service.read(code);
		model.addAttribute("employee", employee);
	}
	
	@PostMapping("detail")
	public ResponseEntity<EmployeeVO> getEmpDetail(long employeeNo) {
		
		EmployeeVO employee = service.read(employeeNo);
		log.info(employee.getEMP_BIRTH());
		log.info("원준");
		/*
		 * SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		 * simpleDateFormat.format(employee.getEMP_BIRTH());
		 */
		
		return new ResponseEntity<>(employee, HttpStatus.OK);
	}
	
	
	@GetMapping("/list")
	public void getList(Model model) {
		
		List<DepartmentVO> deptList = service.getDeptList();
		List<StoreVO> storeList =storeService.getList();
		List<RankVO> rankList = service.getRankList();		
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("storeList", storeList);
		model.addAttribute("rankList", rankList);
	}
	
	@PostMapping("/modify")
	public void getModify(Model model, Long empCode) {
		
		  List<RankVO> rankList = service.getRankList();
		  List<DepartmentVO> deptList =service.getDeptList();
		  List<StoreVO> storeList = storeService.getList();
		  EmployeeVO employee = service.read(empCode);
		  
		  model.addAttribute("employee", employee);
		  model.addAttribute("storeList", storeList);
		  model.addAttribute("rankList", rankList);
		  model.addAttribute("deptList", deptList);		
	}
	
	@PostMapping("/search")
	public ResponseEntity<List<EmployeeVO>> searchEmployee(EmployeeVO vo) {
	
		List<EmployeeVO> list = service.search(vo);

		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/resign")
	@PreAuthorize("isAuthenticated()")
	public void resignEmployee(Model model) {
	
		List<DepartmentVO> deptList = service.getDeptList();
		List<StoreVO> storeList =storeService.getList();
		List<RankVO> rankList = service.getRankList();		

		model.addAttribute("deptList", deptList);
		model.addAttribute("storeList", storeList);
		model.addAttribute("rankList", rankList);
	}
	
	@PostMapping("/resign")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> resign(EmployeeVO vo) {
		log.info("컨");
		log.info(vo);
		
		service.resign(vo);
		return new ResponseEntity<String> ("success", HttpStatus.OK);
		
	}
	

	@GetMapping("/findpw")
	public void findpw() {
	}
	 
	//인증번호 발송
	@PostMapping("/sendemail")
	@ResponseBody
	public ResponseEntity<String> mailCerti(String empCode, String email, HttpSession session){
	
		long empCodeL = Long.parseLong(empCode);
		EmployeeVO employee = service.read(empCodeL);
		
		if(employee == null) {
			return new ResponseEntity<>("noCode", HttpStatus.OK);
		}else {
			
			String empEmail = employee.getEMP_EMAIL();
			if(empEmail.equals(email)) {
				int certiNum = service.getCertiNum();	//인증번호를 가져온다.
				session.setAttribute("certiNum", certiNum);
				
				service.mailSend(email, certiNum);
				
				return new ResponseEntity<>("success", HttpStatus.OK);
				
			}else {
				return new ResponseEntity<>("noEmail", HttpStatus.OK);
			}	
		}
	}
	
	@PostMapping("/certi-check")
	public ResponseEntity<String> certiCheck(Integer certiNum, HttpSession session){
		
		if( certiNum.equals(session.getAttribute("certiNum"))) {
			return new ResponseEntity<>("correct", HttpStatus.OK);			
		}else {
			return new ResponseEntity<>("wrong", HttpStatus.OK);
		}
	}
	
	@PostMapping("/pw-reset")
	public String postPwReset(long empCode, RedirectAttributes rttr) {
		
		EmployeeVO employee = service.read(empCode);
		rttr.addFlashAttribute("employee", employee);
		log.info(employee);
		log.info("원준");
		return "redirect:/employee/pw-reset";
	}
	
	
	@GetMapping("/pw-reset")
	public void getPwReset() {}
	
	@PostMapping("/pw-change")
	public String changePw(EmployeeVO vo) {
		service.updatePassword(vo);
		return "redirect:/main/home";
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
	
	@PostMapping("/edit")
	public String editEmployee(EmployeeVO vo) {
		
		String address1 = vo.getEMP_ADDRESS();
		String address2 = vo.getEMP_ADDRESS_SUB();
		
		vo.setEMP_ADDRESS((address1+ " " +address2).trim());
		service.edit(vo);
		return "redirect:/employee/list";
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
