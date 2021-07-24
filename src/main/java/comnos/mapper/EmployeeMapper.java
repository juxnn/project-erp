package comnos.mapper;

import java.util.List;

import comnos.domain.AuthVO;
import comnos.domain.DepartmentVO;
import comnos.domain.EmployeeVO;
import comnos.domain.RankVO;

public interface EmployeeMapper {

	public List<EmployeeVO> getList();
	
	public int insert(EmployeeVO vo);
	public EmployeeVO read(long employCode);
	public int update(EmployeeVO vo);
	public int remove(EmployeeVO vo);
	
	
	
	public int insertAuth(AuthVO vo);
	public int removeAuth(EmployeeVO vo);

	public RankVO readRank(int rank);
	public DepartmentVO readDept(int dept);

	public List<RankVO> getRankList();
	public List<DepartmentVO> getDeptList();
	
	
	

}
