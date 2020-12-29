package com.sp.app.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto, String pathname) throws Exception;
	
	public void updateMembership(Map<String, Object> map) throws Exception;
	public void updateLastLogin(String userId) throws Exception;
	public void updateMember(Member dto, String pathname) throws Exception;
	
	public Member readMember(String userId);
	public Member readMember(long memberIdx);
	
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	
	
	public Member readProfile(String userId) throws Exception;
	public List<Member> listFollower(Map<String, Object> map);
	public List<Member> listFollowing(Map<String, Object> map);
	public int FollowerCount(String userId);
	public int FollowingCount(String userId);
	public void deleteFollower(Map<String, Object> map) throws Exception;
	public void insertFollow(Map<String, Object> map) throws Exception;
	public int followCheck(Map<String, Object> map) throws Exception;

	//public void deleteFollower(String userId1) throws Exception;
	//public void deleteFollowing(String userId2) throws Exception;
	
}
 