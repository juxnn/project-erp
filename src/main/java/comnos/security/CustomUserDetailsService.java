package comnos.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import comnos.domain.EmployeeVO;
import comnos.mapper.EmployeeMapper;
import comnos.security.domain.CustomUser;
import lombok.Setter;

public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_=@Autowired)
	private EmployeeMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EmployeeVO vo  = mapper.read(Long.valueOf(username));
		
		if (vo == null) {
			throw new UsernameNotFoundException("사용자를 찾을 수 없습니다. username: " + username);
		}
		
		return new CustomUser(vo);
	}
	

}
