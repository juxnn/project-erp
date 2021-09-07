package comnos.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import comnos.domain.DepartmentVO;
import comnos.domain.EmployeeVO;
import comnos.domain.RankVO;

public interface EmployeeService {
	
	public EmployeeVO read(Long code);
	public List<EmployeeVO> getList();
	public boolean insert(EmployeeVO vo);
	public List<RankVO> getRankList();
	public List<DepartmentVO> getDeptList();
	public int getCertiNum();
	public void mailSend(String email, int certiNum);
	public List<EmployeeVO> search(EmployeeVO vo);
	public void updatePassword(EmployeeVO vo);
	public void edit(EmployeeVO vo);
	public void resign(EmployeeVO vo);


}
