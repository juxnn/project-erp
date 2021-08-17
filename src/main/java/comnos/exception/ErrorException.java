package comnos.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class ErrorException {

	@ExceptionHandler(Exception.class)
	public String errorExcept(Exception e, Model model) {
		
		log.error("Exception..." + e.getMessage());
		model.addAttribute("exception", e);
		log.error(model);
		return "/error/error";
	}

	//404와 같이 잘못된 주소로 인해 발생하는 에러는 web.xml 설정으로 하는 것이 처리 방법이 더 빠르다.
	/*
	 * @ExceptionHandler(NoHandlerFoundException.class)
	 * 
	 * @ResponseStatus(HttpStatus.NOT_FOUND) public String
	 * handle404(NoHandlerFoundException ex) { return "/error/404error"; }
	 */
	
}
