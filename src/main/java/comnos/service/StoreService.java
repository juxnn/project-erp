package comnos.service;

import java.util.List;

import comnos.domain.StoreVO;

public interface StoreService {
	
	//CRUD
	public void addStore(StoreVO store);
	public StoreVO get(long sno);
	public boolean modify(StoreVO store);
	public boolean remove(long sno);
	
	
	public List<StoreVO> getList();


}
