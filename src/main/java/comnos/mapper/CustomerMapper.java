package comnos.mapper;

import java.util.List;

import comnos.domain.CustomerVO;

public interface CustomerMapper {
	
	public List<CustomerVO> getList();
	
	public int insert(CustomerVO vo);
	public CustomerVO read(long cno);
	public int update(CustomerVO vo);
	public int delete(long cno);

}
