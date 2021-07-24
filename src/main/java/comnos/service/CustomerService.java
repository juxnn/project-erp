package comnos.service;

import java.util.List;

import comnos.domain.CustomerVO;

public interface CustomerService {
	
	//CRUD
	
	public void addCustomer(CustomerVO customer);
	public CustomerVO get(long cno);
	public boolean modify(CustomerVO customer);
	public boolean remove(long cno);
	
	public List<CustomerVO> getList();

}
