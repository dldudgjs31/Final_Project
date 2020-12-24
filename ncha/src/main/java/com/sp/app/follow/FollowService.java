package com.sp.app.follow;

import java.util.Map;

public interface FollowService {
	public int FollowerCount(Map<String, Object>map);
	public int FollowingCount(Map<String, Object>map);
}
