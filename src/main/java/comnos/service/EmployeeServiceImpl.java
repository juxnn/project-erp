package comnos.service;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import comnos.domain.AuthVO;
import comnos.domain.DepartmentVO;
import comnos.domain.EmployeeVO;
import comnos.domain.RankVO;
import comnos.mapper.EmployeeMapper;
import lombok.Setter;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Setter(onMethod_=@Autowired)
	private EmployeeMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Setter(onMethod_ = @Autowired)
	private JavaMailSender mailSender;
	
	@Override
	public EmployeeVO read(Long code) {
		return mapper.read(code);
	}
	
	@Override
	public List<EmployeeVO> getList() {
		return mapper.getList();
	}
	
	@Override
	@Transactional
	public boolean insert(EmployeeVO vo) {
		
		//패스워드 암호화
		vo.setEMP_PASSWORD(encoder.encode(vo.getEMP_PASSWORD()));
		int cnt = mapper.insert(vo);
		
		
		//입력값에서 권한 읽어오기 
		int deptNum = vo.getDEPT_NO();
		int rankNum = vo.getRANK_NO();

		RankVO rankRole = mapper.readRank(rankNum);
		DepartmentVO deptRole = mapper.readDept(deptNum);
		
		//권한입력
		AuthVO avo = new AuthVO();
		avo.setEMP_CODE(vo.getEMP_CODE());
		
		avo.setAUTH(rankRole.getRANK_ROLE());
		mapper.insertAuth(avo);
		
		avo.setAUTH(deptRole.getDEPT_ROLE());
		mapper.insertAuth(avo);
		
		return cnt == 1;
	}
	
	@Override
	public List<RankVO> getRankList() {
		return mapper.getRankList();
	}
	
	@Override
	public List<DepartmentVO> getDeptList() {
		return mapper.getDeptList();
	}
	
	@Override
	public int getCertiNum() {
		return ThreadLocalRandom.current().nextInt(100000, 1000000);
	}

	@Override
	public void mailSend(String email, int certiNum) {
		//int certiNum = getCertiNum();
		//인증번호 저장해주는 곳이 필요함. 아마도 세션일듯?
		//시간은 3분
		//jsp에 시간 띄워주는것도 좋을 것 같다.

		try {		
			MimeMessage mimeMessage = mailSender.createMimeMessage();
		    MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
 
		    messageHelper.setFrom("comnosGM@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
		    messageHelper.setTo(email); // 받는사람 이메일
		    
		    messageHelper.setSubject("컴노스 인증번호"); // 메일제목
		    messageHelper.setText("인증번호는 <" + certiNum + "> 입니다."); // 메일 내용
		    
		    mailSender.send(mimeMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void updatePassword(EmployeeVO vo) {
	
		vo.setEMP_PASSWORD(encoder.encode(vo.getEMP_PASSWORD()));
		mapper.updatePassword(vo);
		
	}
	
	@Override
	public List<EmployeeVO> search(EmployeeVO vo) {
		return mapper.search(vo);
	}
	
@Override
	public void edit(EmployeeVO vo) {
		mapper.edit(vo);
	}
}























