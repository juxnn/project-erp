package comnos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.domain.StoreVO;
import comnos.mapper.StoreMapper;
import lombok.Setter;

@Service
public class StoreServiceImpl implements StoreService{

	@Setter(onMethod_=@Autowired)
	private StoreMapper mapper;
	
	@Override
	public List<StoreVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public void addStore(StoreVO store) {
		String address = store.getSTORE_ADDRESS() + " " + store.getSTORE_ADDRESS_SUB();
		store.setSTORE_ADDRESS(address);
		mapper.insert(store);
		
	}

	@Override
	public StoreVO get(long sno) {
		return mapper.read(sno);
	}
	@Override
	public boolean modify(StoreVO store) {
		return mapper.update(store) == 1;
	}
	@Override
	public boolean remove(long sno) {
		return mapper.delete(sno) ==1 ;
	}
	
}
