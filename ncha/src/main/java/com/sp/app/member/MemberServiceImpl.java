package com.sp.app.member;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;

	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private MailSender mailSender;
	
	@Override
	public Member loginMember(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void insertMember(Member dto, String pathname) throws Exception {
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
			
			long memberSeq = dao.selectOne("member.memberSeq");
			dto.setMemberIdx(memberSeq);
			
			dao.updateData("member.insertMember12", dto); 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Member readMember(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.readMember1", userId);
			
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
	public Member readMember(long memberIdx) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.readMember", memberIdx);
			
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
	public void updateMembership(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateMembership", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateMember(Member dto, String pathname) throws Exception {
		try {
			
			String serverFilename = fileManager.doFileUpload(dto.getUploadphoto(), pathname);
			if(serverFilename != null) {
				if(dto.getProfile_imageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getProfile_imageFilename(), pathname);
				}
			}
			
			dto.setProfile_imageFilename(serverFilename);
			
			
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("member.updateMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("member.updateMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			map.put("membership", 0);
			updateMembership(map);
			
			dao.deleteData("member.deleteMember", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		
		try {
			list=dao.selectList("list.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Member readProfile(String userId) throws Exception {
		Member dto= null;
		try {
			dto=dao.selectOne("member.readProfile", userId);
			dto.setFollowerCount(dao.selectOne("member.followerCount",userId));
			dto.setFollowingCount(dao.selectOne("member.followingCount",userId));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}

	@Override
	public List<Member> listFollower(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.followerList", map);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Member> listFollowing(Map<String, Object> map) {
		List<Member> list=null;
		try {		
			list=dao.selectList("member.followingList", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int FollowerCount(String userId) {		
		int result = 0;	
		try {
			result = dao.selectOne("member.followerCount",userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int FollowingCount(String userId) {
		int result = 0 ;		
		try {
			result = dao.selectOne("member.followingCount",userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteFollower(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("member.deleteFollower",map);	
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void insertFollow(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("member.insertFollow",map);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public int followCheck(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("member.followCheckCount",map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public List<Member> rankFollower() {
		List<Member> list=null;
		
		try {
			list=dao.selectList("member.rankFollower");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateProfile(Member dto, String pathname) throws Exception {
		try {
	
		String serverFilename = fileManager.doFileUpload(dto.getUploadphoto(), pathname);
		if(serverFilename != null) {
			if(dto.getProfile_imageFilename().length()!=0) {
				fileManager.doFileDelete(dto.getProfile_imageFilename(), pathname);
				dto.setProfile_imageFilename(serverFilename);
				dao.updateData("member.updateProfile", dto);
			}
		}

		
	} catch (Exception e) {
		e.printStackTrace();
		throw e;
	}
  }
	
	@Override
	public void generatePwd(Member dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		String s="!@#$%^&*~-+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
		for(int i=0; i<10; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n, n+1));
		}
		
		String result;
		result = dto.getUserId()+"님의 새로 발급된 임시 패스워드는 <b>"
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
			dto.setUserPwd(sb.toString());
			updateMember(dto);
		} else {
			throw new Exception("이메일 전송중 오류가 발생했습니다.");
		}
	}
}
