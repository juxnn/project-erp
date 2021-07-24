package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.CustomerVO;
import comnos.mapper.CustomerMapper;
import lombok.Setter;

@Service
public class CustomerServiceImpl implements CustomerService{

	@Setter(onMethod_=@Autowired)
	private CustomerMapper mapper;
	
	@Override
	public List<CustomerVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public void addCustomer(CustomerVO customer) {
		mapper.insert(customer);
	}
	@Override
	public CustomerVO get(long cno) {
		return mapper.read(cno);
	}
	 
	@Override
	public boolean modify(CustomerVO customer) {
		return mapper.update(customer) == 1;
	}
	 
	@Override
	public boolean remove(long cno) {
		return mapper.delete(cno) == 1;
	}
	
}
