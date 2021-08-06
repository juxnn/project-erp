package comnos.service;

import java.util.Date;

public interface ComputeService {

	String mimeOrderNumberA(int number);
	String mimeOrderNumberB(int number);
	String mimeOrderNumberC(int number);
	String mimeOrderNumberD(int number);
	long mimeEmpCode(Date empDate);
}
