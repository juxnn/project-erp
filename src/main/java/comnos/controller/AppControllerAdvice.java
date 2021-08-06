package comnos.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@ControllerAdvice(annotations = Controller.class)
@AllArgsConstructor
@Log4j
public class AppControllerAdvice {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		log.info("binder date....");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(
	            dateFormat, true));
	}
	
	@ModelAttribute
	public void lists(Model model) {
		log.info("model select.....");
//		List<RankVO> rankList = service.getRankList();
//		List<DepartmentVO> deptList = service.getDeptList();
//		List<StoreVO> storeList =storeService.getList();
		
//		model.addAttribute("storeList", storeList);
//		model.addAttribute("rankList", rankList);
//		model.addAttribute("deptList", deptList);
	}
}
