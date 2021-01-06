package com.sp.app.seller;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;

@Service("seller.sellerService")
public class SellerServiceImpl implements SellerService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private MailSender mailSender;
	
	@Override
	public Seller loginSeller(String sellerId) {
		Seller dto=null;
		
		try {
			dto=dao.selectOne("seller.loginSeller", sellerId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;

	}

	@Override
	public void insertSeller(Seller dto,String pathname) throws Exception {
		try {
			String serverFilename = fileManager.doFileUpload(dto.getUploadphoto(), pathname);
			if(serverFilename != null) {
				dto.setProfile_imageFilename(serverFilename);
			}
			
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.insertData("seller.insertSeller", dto);  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public void updateLastLogin(String sellerId) throws Exception {
		try {
			dao.updateData("seller.updateLastLogin", sellerId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateSeller(Seller dto, String pathname) throws Exception {
		try {
			
			String serverFilename = fileManager.doFileUpload(dto.getUploadphoto(), pathname);
			if(serverFilename != null) {
				if(dto.getProfile_imageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getProfile_imageFilename(), pathname);
				}
				dto.setProfile_imageFilename(serverFilename);
			}
			
			 
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("seller.updateSeller", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}
	
	@Override
	public void updateSeller(Seller dto) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("seller.updateSeller", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public Seller readSeller(String sellerId) {
		Seller dto=null;
		
		try {
			dto=dao.selectOne("seller.readSeller", sellerId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteSeller(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("seller.deleteSeller", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountSeller", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Seller> listSeller(Map<String, Object> map) {
		List<Seller> list=null;
		
		try {
			list=dao.selectList("list.listSeller", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	@Override
	public void generatePwd(Seller dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		String s="!@#$%^&*~-+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
		for(int i=0; i<10; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n, n+1));
		}
		
		String result;
		result = dto.getSellerId()+"님의 새로 발급된 임시 패스워드는 <b>"
		         + sb.toString()+"</b> 입니다.<br>"
		         + "로그인 후 반드시 패스워드를 변경 하시기 바랍니다.";
		
		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getEmail());
		
		mail.setSenderEmail("bbomi1113@naver.com");
		mail.setSenderName("N차_신상");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			dto.setPwd(sb.toString());
			updateSeller(dto);
		} else {
			throw new Exception("이메일 전송중 오류가 발생했습니다.");
		}
	}
}
