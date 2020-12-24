package com.sp.app.follow;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("follow.followService")
public class FollowServiceImpl implements FollowService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int FollowerCount(Map<String, Object> map) {
		int result = 0 ;
		
		try {
			result = dao.selectOne("member.followerCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int FollowingCount(Map<String, Object> map) {
		int result = 0 ;
		
		try {
			result = dao.selectOne("member.followingCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
