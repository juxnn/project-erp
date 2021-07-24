package comnos.mapper;

import comnos.domain.FileVO;

public interface FileMapper {
	
	public int insert(FileVO vo);
	
	public void deleteByPno(String pno);

}
