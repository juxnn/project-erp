package comnos.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import comnos.mapper.EmployeeMapper;
import comnos.mapper.OrderMapper;
import comnos.mapper.StoreInMapper;
import comnos.mapper.StoreOrderMapper;
import comnos.mapper.StoreOutMapper;
import lombok.Setter;

@Service
public class ComputeServiceImpl implements ComputeService{
	
	@Setter(onMethod_=@Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_=@Autowired)
	private EmployeeMapper employeeMapper;
	
	@Setter(onMethod_=@Autowired)
	private StoreOrderMapper storeOrderMapper;
	
	@Setter(onMethod_=@Autowired)
	private StoreOutMapper storeOutMapper;
	
	@Setter(onMethod_=@Autowired)
	private StoreInMapper storeInMapper;
	
	@Override
	public long mimeEmpCode(Date empDate) {
		
		
		Random random = new Random();
		int x = random.nextInt(99);
		String ranNum = String.format("%02d", x);

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String dateStr = dateFormat.format(empDate);
		
		long empCode = Long.parseLong(dateStr + ranNum);
		
		
		if(employeeMapper.checkEmpCode(empCode) == 1) {
			return mimeEmpCode(empDate);
		}else {
			return empCode;
		}
	}
	
	
	@Override
	public String mimeOrderNumberA(int number) {
		
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String orderNo = dateFormat.format(date) + "-A" + String.format("%02d", number);
		
		if(orderMapper.checkOrderNo(orderNo) == 1) {	//번호가 있다면
			return mimeOrderNumberA(number+1);
		}else {
			return orderNo;
		}
	}
	
	@Override
	public String mimeOrderNumberB(int number) {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String orderNo = dateFormat.format(date) + "-B" + String.format("%02d", number);
		
		if(storeOrderMapper.checkOrderNo(orderNo) == 1) {	//번호가 있다면
			return mimeOrderNumberB(number+1);
		}else {
			return orderNo;
		}
	}
	
	@Override
	public String mimeOrderNumberC(int number) {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String orderNo = dateFormat.format(date) + "-C" + String.format("%02d", number);
		
		if(storeOutMapper.checkOrderNo(orderNo) == 1) {	//번호가 있다면
			return mimeOrderNumberC(number+1);
		}else {
			return orderNo;
		}
	}
	
	
	@Override
	public String mimeOrderNumberD(int number) {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String orderNo = dateFormat.format(date) + "-D" + String.format("%02d", number);
		
		if(storeInMapper.checkOrderNo(orderNo) == 1) {	//번호가 있다면
			return mimeOrderNumberD(number+1);
		}else {
			return orderNo;
		}
	}
	
	
	
	
	
	
	
}
