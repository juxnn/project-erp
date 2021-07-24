package comnos.mapper;

import java.util.List;

import comnos.domain.StoreVO;

public interface StoreMapper {
	
	public List<StoreVO> getList();
	
	public int insert(StoreVO vo);
	
	public StoreVO read(long sno);
	
	public int update(StoreVO vo);
	
	public int delete(long sno);
	
	

}
