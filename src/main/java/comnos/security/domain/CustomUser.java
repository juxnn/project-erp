package comnos.security.domain;

import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import comnos.domain.EmployeeVO;

import lombok.Getter;
import lombok.Setter;

public class CustomUser extends User{
	
	@Getter
	@Setter
	private EmployeeVO employee;
	
	/*
	public CustomUser(Long EMP_CODE, String EMP_PASSWORD, Collection<? extends GrantedAuthority> authorities) {
		super(EMP_CODE.toString(), EMP_PASSWORD, authorities);
	}
	*/

	public CustomUser(EmployeeVO vo) {
		
		super(vo.getEMP_CODE() + "", vo.getEMP_PASSWORD(), vo.getAUTH_LIST().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAUTH()))
				.collect(Collectors.toList()));
		
		employee = vo;
	}
	
}
